public class CourseClass {

    public list<Course__c> courses {get;set;}
    public list<Student__c> Students {get;set;}
    public list<StudentAndCourse__c> stuAndCou {get; set;}
    public Course__c courObj{get;set;}
    //  Flags
    public boolean flagTrue {get;set;}
    public boolean showStudentFlag{get;set;}
    public boolean insertCourse {get;set;}
    
    // Ids
    public id courseId {get;set;}
    public id courDeleteId{get;set;}
    // string value
    public string courName{get;set;}
    public CourseClass(){
        courses = new list<Course__c>();
        courses = showCourse();
        Students = new list<Student__c>();
        courObj = new Course__c();
        stuAndCou = new List<StudentAndCourse__c>();
        flagTrue = False;
        showStudentFlag = false;
        insertCourse = false;
    }
     public list<Course__c> showCourse(){
        list<Course__c> courList = [Select Name,Course_Id__c,CourseRegisNo__c from Course__c order by Course_Id__c];
        return courList;
    }
    public void showStudents(){
        showStudentFlag = true;
        List<Student__c> stud = new list<Student__c>();
        list<StudentAndCourse__c> stuAndCou = [Select StudentName__r.Name,StudentName__r.Stu_Email__c,StudentName__r.Roll_No__c,StudentName__r.RegistrationsNumber__c from StudentAndCourse__C
                                              where CourseName__c =:courseId];
        for(StudentAndCourse__c co : stuAndCou){
            stud.add(new Student__c(Name=co.StudentName__r.Name,
                                     Stu_Email__c=co.StudentName__r.Stu_Email__c       
                                           ));
            Students = stud;
        }
    }
    public void DeleteCourse(){
        courObj = [Select id ,Name,Course_Id__c,CourseRegisNo__c from Course__c
                  where  id=:courDeleteId ];
        try{
        Delete courObj;
        }
        catch(dmlException e){
            system.debug(e.getMessage());
        }
    }
    public void CreateCourse(){
        Course__c cour = new Course__c( Name = courName);
        system.debug(courName);
        try{

            insert cour;
            courName = null;
        }
        catch(dmlException e){
            system.debug(e.getMessage());
        }
    }
    public void FlagTrue(){
        insertCourse = true;
    }
}