package com.veteranapp.backend.service;

import com.veteranapp.backend.model.*;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class DataService {

    private final List<User> users;
    private final List<Organization> organizations;
    private final List<Official> officials;
    private final List<News> newsList;
    private final List<Member> members;
    private final List<Meeting> meetings;
    private final Map<String, Constitution> constitutions;
    private final SoccerMatch currentSoccerMatch;

    public DataService() {
        // Initialize organizations
        organizations = Arrays.asList(
            new Organization("org1", "Veterans United", "New York, NY"),
            new Organization("org2", "Heroes Association", "Los Angeles, CA"),
            new Organization("org3", "Freedom Veterans", "Chicago, IL")
        );

        // Initialize users (passwords should be hashed in production)
        users = Arrays.asList(
            new User("1", "admin", "admin@veteranapp.com", "admin123", "Admin User", 
                     Arrays.asList("org1", "org2", "org3")),
            new User("2", "johndoe", "john.doe@example.com", "password123", "John Doe", 
                     Arrays.asList("org1", "org2")),
            new User("3", "janedoe", "jane.doe@example.com", "password123", "Jane Doe", 
                     Arrays.asList("org1"))
        );

        // Initialize officials for each organization
        officials = new ArrayList<>();
        // org1 officials
        officials.add(new Official("org1", "Gen. James Mitchell", "President", "U.S. Army", 
                                   "https://example.com/james.jpg"));
        officials.add(new Official("org1", "Col. Sarah Johnson", "Vice President", "U.S. Air Force", null));
        officials.add(new Official("org1", "Cdr. Michael Chen", "Secretary", "U.S. Navy", null));
        officials.add(new Official("org1", "Maj. David Williams", "Treasurer", "U.S. Marine Corps", null));
        officials.add(new Official("org1", "Sgt. Robert Davis", "Organizing Secretary", "U.S. Army", null));
        officials.add(new Official("org1", "Lt. Emily Rodriguez", "Social Secretary", "U.S. Air Force", null));
        officials.add(new Official("org1", "Capt. Thomas Anderson", "Provost", "U.S. Navy", null));
        
        // org2 officials
        officials.add(new Official("org2", "Gen. Patricia Moore", "President", "U.S. Army", null));
        officials.add(new Official("org2", "Col. William Taylor", "Vice President", "U.S. Marine Corps", null));
        officials.add(new Official("org2", "Cdr. Jennifer Lee", "Secretary", "U.S. Navy", null));
        
        // org3 officials
        officials.add(new Official("org3", "Gen. Charles Brown", "President", "U.S. Air Force", null));
        officials.add(new Official("org3", "Col. Lisa Martinez", "Vice President", "U.S. Army", null));

        // Initialize news for each organization
        newsList = new ArrayList<>();
        // org1 news
        newsList.add(new News("org1", "Annual Gala Dinner", 
                             "Join us for our annual gala dinner celebrating our veterans", 
                             "Mar 15, 2026", "Event", 
                             "https://example.com/gala.jpg"));
        newsList.add(new News("org1", "Scholarship Program Launch", 
                             "New scholarship program for veterans' children", 
                             "Feb 28, 2026", "Announcement", null));
        newsList.add(new News("org1", "Community Outreach Success", 
                             "Our community outreach program helped 500 veterans this month", 
                             "Feb 20, 2026", "Achievement", null));
        newsList.add(new News("org1", "Monthly Meeting Notice", 
                             "Next monthly meeting scheduled for March 10th at 6 PM", 
                             "Feb 15, 2026", "Meeting", null));
        newsList.add(new News("org1", "Health Fair Announcement", 
                             "Free health screenings for all members on March 25th", 
                             "Feb 10, 2026", "Event", null));
        
        // org2 news
        newsList.add(new News("org2", "Veterans Day Parade", 
                             "Annual parade planning committee meeting", 
                             "Mar 10, 2026", "Event", null));
        newsList.add(new News("org2", "New Member Orientation", 
                             "Welcome session for new members", 
                             "Mar 05, 2026", "Meeting", null));
        
        // org3 news
        newsList.add(new News("org3", "Fundraising Campaign", 
                             "Spring fundraising campaign kicks off", 
                             "Mar 08, 2026", "Announcement", null));

        // Initialize members for each organization
        members = new ArrayList<>();
        // org1 members
        members.add(new Member("1", "org1", "John Smith", "New York, NY", true, "active", 
                              "Member", "U.S. Army"));
        members.add(new Member("2", "org1", "Jane Doe", "Brooklyn, NY", true, "active", 
                              "Member", "U.S. Navy"));
        members.add(new Member("3", "org1", "Michael Brown", "Queens, NY", false, "active", 
                              "Member", "U.S. Air Force"));
        members.add(new Member("4", "org1", "Sarah Wilson", "Manhattan, NY", true, "suspended", 
                              "Member", "U.S. Marine Corps"));
        members.add(new Member("5", "org1", "David Lee", "Bronx, NY", false, "dismissed", 
                              "Former Member", "U.S. Army"));
        members.add(new Member("6", "org1", "Emily Davis", "Staten Island, NY", true, "active", 
                              "Member", "U.S. Coast Guard"));
        members.add(new Member("7", "org1", "James Martinez", "Long Island, NY", true, "active", 
                              "Senior Member", "U.S. Army"));
        members.add(new Member("8", "org1", "Lisa Anderson", "Yonkers, NY", false, "active", 
                              "Member", "U.S. Air Force"));
        members.add(new Member("9", "org1", "Robert Taylor", "White Plains, NY", true, "active", 
                              "Member", "U.S. Navy"));
        members.add(new Member("10", "org1", "Jennifer Thomas", "New Rochelle, NY", true, "active", 
                              "Member", "U.S. Marine Corps"));
        
        // org2 members
        members.add(new Member("11", "org2", "William Garcia", "Los Angeles, CA", true, "active", 
                              "Member", "U.S. Army"));
        members.add(new Member("12", "org2", "Maria Rodriguez", "Hollywood, CA", true, "active", 
                              "Member", "U.S. Navy"));
        
        // org3 members
        members.add(new Member("13", "org3", "Christopher White", "Chicago, IL", true, "active", 
                              "Member", "U.S. Air Force"));

        // Initialize meetings for each organization
        meetings = new ArrayList<>();
        // org1 meetings
        Meeting.ActionPoint ap1 = new Meeting.ActionPoint(
            "Update membership database", "Secretary", "Mar 01, 2026", "In Progress"
        );
        Meeting.ActionPoint ap2 = new Meeting.ActionPoint(
            "Plan annual gala", "Social Secretary", "Mar 15, 2026", "Not Started"
        );
        Meeting.Fine fine1 = new Meeting.Fine("John Smith", 25.00, "Late arrival");
        Meeting.Fine fine2 = new Meeting.Fine("Jane Doe", 50.00, "Missed previous meeting");
        
        meetings.add(new Meeting(
            "1", "org1", "Monthly General Meeting", "Feb 12, 2026", 
            "Veterans Hall, 123 Main St", 45,
            "Meeting called to order at 6:00 PM. President welcomed all members...",
            Arrays.asList(ap1, ap2),
            Arrays.asList(fine1, fine2)
        ));
        
        meetings.add(new Meeting(
            "2", "org1", "Executive Committee Meeting", "Feb 05, 2026",
            "Conference Room A", 7,
            "Executive committee reviewed budget proposals...",
            Arrays.asList(ap1),
            new ArrayList<>()
        ));
        
        // org2 meetings
        meetings.add(new Meeting(
            "3", "org2", "Planning Committee", "Feb 10, 2026",
            "Community Center", 15,
            "Committee discussed upcoming events...",
            new ArrayList<>(),
            new ArrayList<>()
        ));

        // Initialize constitutions
        constitutions = new HashMap<>();
        
        // org1 constitution
        Constitution.Section s1 = new Constitution.Section("1.1", 
            "The name of this organization shall be Veterans United.");
        Constitution.Section s2 = new Constitution.Section("1.2", 
            "The organization is a non-profit entity dedicated to serving veterans.");
        Constitution.Article a1 = new Constitution.Article("Article I: Name and Purpose", 
            Arrays.asList(s1, s2));
        
        Constitution.Section s3 = new Constitution.Section("2.1", 
            "Membership is open to all honorably discharged veterans.");
        Constitution.Section s4 = new Constitution.Section("2.2", 
            "Annual dues shall be determined by the general assembly.");
        Constitution.Article a2 = new Constitution.Article("Article II: Membership", 
            Arrays.asList(s3, s4));
        
        constitutions.put("org1", new Constitution(
            "org1", "Veterans United",
            Arrays.asList(a1, a2),
            "Jan 15, 2020", "Dec 10, 2025"
        ));
        
        // org2 constitution
        constitutions.put("org2", new Constitution(
            "org2", "Heroes Association",
            Arrays.asList(a1),
            "Mar 20, 2019", "Nov 15, 2024"
        ));

        // Initialize soccer match
        currentSoccerMatch = createSoccerMatch();
    }

    private SoccerMatch createSoccerMatch() {
        SoccerMatch match = new SoccerMatch();
        match.setMatchDay("Feb 12, 2026");
        match.setHomeTeam("Veterans FC");
        match.setAwayTeam("Heroes United");
        match.setHomeScore(3);
        match.setAwayScore(2);
        match.setReferee("Referee John Smith");
        match.setAssistantReferee1("Assistant Ref Mike Johnson");
        match.setAssistantReferee2("Assistant Ref Sarah Williams");
        
        List<SoccerMatch.Goal> goals = Arrays.asList(
            new SoccerMatch.Goal("James Mitchell", "15'", "Home"),
            new SoccerMatch.Goal("David Lee", "28'", "Away"),
            new SoccerMatch.Goal("Robert Davis", "45+2'", "Home"),
            new SoccerMatch.Goal("Michael Chen", "67'", "Away"),
            new SoccerMatch.Goal("Thomas Anderson", "82'", "Home")
        );
        
        List<SoccerMatch.Assist> assists = Arrays.asList(
            new SoccerMatch.Assist("Michael Chen", "15'", "Home"),
            new SoccerMatch.Assist("Thomas Anderson", "28'", "Away"),
            new SoccerMatch.Assist("James Mitchell", "45+2'", "Home"),
            new SoccerMatch.Assist("Robert Davis", "67'", "Away"),
            new SoccerMatch.Assist("David Williams", "82'", "Home")
        );
        
        List<SoccerMatch.Card> yellowCards = Arrays.asList(
            new SoccerMatch.Card("David Williams", "33'", "Home", "Unsporting behavior"),
            new SoccerMatch.Card("Emily Rodriguez", "58'", "Away", "Tactical foul")
        );
        
        List<SoccerMatch.Card> redCards = new ArrayList<>();
        
        match.setGoals(goals);
        match.setAssists(assists);
        match.setYellowCards(yellowCards);
        match.setRedCards(redCards);
        
        return match;
    }

    // User methods
    public Optional<User> findUserByUsername(String username) {
        return users.stream()
                .filter(u -> u.getUsername().equals(username))
                .findFirst();
    }

    public Optional<User> findUserById(String userId) {
        return users.stream()
                .filter(u -> u.getId().equals(userId))
                .findFirst();
    }

    // Organization methods
    public List<Organization> getAllOrganizations() {
        return new ArrayList<>(organizations);
    }

    public Optional<Organization> getOrganizationById(String orgId) {
        return organizations.stream()
                .filter(o -> o.getId().equals(orgId))
                .findFirst();
    }

    public List<Organization> getOrganizationsByIds(List<String> orgIds) {
        return organizations.stream()
                .filter(o -> orgIds.contains(o.getId()))
                .collect(Collectors.toList());
    }

    // Officials methods
    public List<Official> getOfficialsByOrganization(String organizationId) {
        return officials.stream()
                .filter(o -> o.getOrganizationId().equals(organizationId))
                .collect(Collectors.toList());
    }

    // News methods
    public List<News> getNewsByOrganization(String organizationId) {
        return newsList.stream()
                .filter(n -> n.getOrganizationId().equals(organizationId))
                .collect(Collectors.toList());
    }

    // Member methods
    public List<Member> getMembersByOrganization(String organizationId) {
        return members.stream()
                .filter(m -> m.getOrganizationId().equals(organizationId))
                .collect(Collectors.toList());
    }

    public Optional<Member> getMemberById(String memberId, String organizationId) {
        return members.stream()
                .filter(m -> m.getId().equals(memberId) && m.getOrganizationId().equals(organizationId))
                .findFirst();
    }

    public boolean updateMemberPayment(String memberId, String organizationId, Boolean isPaid) {
        Optional<Member> memberOpt = getMemberById(memberId, organizationId);
        if (memberOpt.isPresent()) {
            memberOpt.get().setIsPaid(isPaid);
            return true;
        }
        return false;
    }

    // Soccer methods
    public SoccerMatch getCurrentSoccerMatch() {
        return currentSoccerMatch;
    }

    public List<SoccerMatch> getSoccerHistory() {
        return Collections.singletonList(currentSoccerMatch);
    }

    // Hosting methods
    public HostingSchedule getCurrentHostingSchedule(String organizationId) {
        return generateHostingSchedule(organizationId, false);
    }

    public HostingSchedule getNextHostingSchedule(String organizationId) {
        return generateHostingSchedule(organizationId, true);
    }

    private HostingSchedule generateHostingSchedule(String organizationId, boolean isNext) {
        List<Member> orgMembers = getMembersByOrganization(organizationId);
        if (orgMembers.isEmpty()) {
            return null;
        }

        LocalDate now = LocalDate.now();
        LocalDate periodStart = now.minusDays(now.getDayOfMonth() - 1); // Start of current month
        
        if (isNext) {
            periodStart = periodStart.plusMonths(1);
        }
        
        LocalDate periodEnd = periodStart.plusMonths(1).minusDays(1);
        
        // Select hosts (first 3 active paid members for demonstration)
        List<Member> hosts = orgMembers.stream()
                .filter(m -> "active".equals(m.getStatus()) && Boolean.TRUE.equals(m.getIsPaid()))
                .limit(3)
                .collect(Collectors.toList());
        
        DateTimeFormatter formatter = DateTimeFormatter.ISO_DATE;
        
        return new HostingSchedule(
                isNext ? "schedule-next" : "schedule-current",
                periodStart.format(formatter),
                periodEnd.format(formatter),
                hosts,
                orgMembers,
                100.0
        );
    }

    // Meeting methods
    public List<Meeting> getMeetingsByOrganization(String organizationId) {
        return meetings.stream()
                .filter(m -> m.getOrganizationId().equals(organizationId))
                .collect(Collectors.toList());
    }

    public Optional<Meeting> getMeetingById(String meetingId, String organizationId) {
        return meetings.stream()
                .filter(m -> m.getId().equals(meetingId) && m.getOrganizationId().equals(organizationId))
                .findFirst();
    }

    // Constitution methods
    public Optional<Constitution> getConstitutionByOrganization(String organizationId) {
        return Optional.ofNullable(constitutions.get(organizationId));
    }
}
