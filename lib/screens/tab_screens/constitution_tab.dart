import 'package:flutter/material.dart';

class ConstitutionTab extends StatelessWidget {
  const ConstitutionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Constitution'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Veterans Organization',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),
            _buildArticle(
              'Article I: Name and Purpose',
              [
                'Section 1: The name of this organization shall be the Veterans Organization.',
                'Section 2: The purpose of this organization is to support and advocate for veterans and their families, to promote camaraderie among veterans, to provide assistance and resources to those in need, and to preserve the memory and legacy of those who have served.',
                'Section 3: This organization shall be non-partisan and non-sectarian in nature.',
              ],
            ),
            _buildArticle(
              'Article II: Membership',
              [
                'Section 1: Membership is open to all veterans who have served honorably in the armed forces of the United States.',
                'Section 2: Associate membership may be granted to family members of veterans and others who support the organization\'s mission.',
                'Section 3: All members in good standing shall have the right to vote on organizational matters.',
                'Section 4: Members who fail to pay dues or violate the code of conduct may have their membership suspended or revoked by a two-thirds vote of the Executive Board.',
              ],
            ),
            _buildArticle(
              'Article III: Rights and Responsibilities',
              [
                'Section 1: All members have the right to participate in organizational activities, attend meetings, and vote on important matters.',
                'Section 2: Members are expected to conduct themselves in a manner that reflects positively on the organization and the veteran community.',
                'Section 3: Members have the responsibility to pay annual dues as determined by the membership.',
                'Section 4: Members are encouraged to volunteer their time and resources to further the organization\'s mission.',
              ],
            ),
            _buildArticle(
              'Article IV: Officers and Executive Board',
              [
                'Section 1: The officers of this organization shall consist of a President, Vice President, Secretary, and Treasurer.',
                'Section 2: Officers shall be elected by majority vote of the membership at the annual meeting and shall serve for a term of two years.',
                'Section 3: The Executive Board shall consist of the elected officers and three at-large members.',
                'Section 4: The Executive Board shall meet quarterly and shall have the authority to manage the affairs of the organization between general membership meetings.',
                'Section 5: Officers may be removed from office for cause by a two-thirds vote of the membership.',
              ],
            ),
            _buildArticle(
              'Article V: Duties of Officers',
              [
                'Section 1: The President shall preside at all meetings, appoint committee chairs, and represent the organization in official matters.',
                'Section 2: The Vice President shall assume the duties of the President in their absence and shall chair the Membership Committee.',
                'Section 3: The Secretary shall keep minutes of all meetings, maintain membership records, and handle correspondence.',
                'Section 4: The Treasurer shall manage the organization\'s finances, collect dues, pay bills, and provide financial reports to the membership.',
              ],
            ),
            _buildArticle(
              'Article VI: Meetings',
              [
                'Section 1: Regular meetings shall be held monthly at a time and place determined by the Executive Board.',
                'Section 2: An annual meeting shall be held in the first quarter of each year for the election of officers and presentation of annual reports.',
                'Section 3: Special meetings may be called by the President or upon written request of ten members.',
                'Section 4: A quorum for conducting business shall consist of fifteen members or twenty percent of the membership, whichever is less.',
              ],
            ),
            _buildArticle(
              'Article VII: Committees',
              [
                'Section 1: The following standing committees shall be maintained: Membership, Programs, Finance, Veterans Assistance, and Community Outreach.',
                'Section 2: The President may appoint special committees as needed to accomplish specific tasks.',
                'Section 3: Committee chairs shall report their activities at regular meetings.',
              ],
            ),
            _buildArticle(
              'Article VIII: Finances',
              [
                'Section 1: The fiscal year of the organization shall be from January 1 to December 31.',
                'Section 2: Annual membership dues shall be determined by a majority vote of the membership.',
                'Section 3: All funds shall be deposited in a bank account in the organization\'s name.',
                'Section 4: The Treasurer shall present a financial report at each regular meeting.',
                'Section 5: An annual audit of the organization\'s finances shall be conducted by an independent auditor or audit committee.',
              ],
            ),
            _buildArticle(
              'Article IX: Amendments',
              [
                'Section 1: This constitution may be amended by a two-thirds vote of the members present at any regular meeting.',
                'Section 2: Proposed amendments must be submitted in writing to the Secretary at least thirty days before the meeting at which they will be considered.',
                'Section 3: Notice of proposed amendments must be provided to the membership at least two weeks before the vote.',
              ],
            ),
            _buildArticle(
              'Article X: Dissolution',
              [
                'Section 1: This organization may be dissolved by a three-fourths vote of the entire membership.',
                'Section 2: In the event of dissolution, all assets shall be distributed to one or more organizations that support veterans or their families, as determined by the membership.',
                'Section 3: No member shall receive any financial benefit from the dissolution of the organization.',
              ],
            ),
            _buildArticle(
              'Article XI: Parliamentary Authority',
              [
                'Section 1: Robert\'s Rules of Order, latest edition, shall govern all meetings of this organization where they are not in conflict with this constitution.',
              ],
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              color: Colors.blue.shade50,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.blue),
                    SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'This constitution was adopted and ratified by the membership.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  static Widget _buildArticle(String title, List<String> sections) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        ...sections.map((section) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 8.0),
              child: Text(
                section,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}
