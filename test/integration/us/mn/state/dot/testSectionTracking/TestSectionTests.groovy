package us.mn.state.dot.testSectionTracking

class TestSectionTests extends GroovyTestCase {

    void testValid() {
        def data = [section:"039532"
                ,groupname:"Centerline Rumble Strips"
                ,routeName:"MNTH95"
                ,system:"MNTH"
                ,route:"95"
                ,district :"3"
                ,sectioncontact:"Jon Jackels, Mn/DOT Traffic-Safety-Ops"
        ]
// and use the data in a test
        def t = new TestSection(data)
        assert t.validate()
    }

}
