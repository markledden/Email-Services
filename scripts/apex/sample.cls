public class CSVDataHandler {
    
    @InvocableMethod(label='Parse CSV to Collection' description='Parse a CSV file to a recod collection' category='Data Manipulation')
    public static List<CSVDataHandlerResult> createEnrolments(List<EnrolmentsRequest> request){
        
        //parse inputs and variables
        List<Account> students = request.get(0).students;
        List<Class__c> classes = request.get(0).classes;
        List<Payment__c> payments = request.get(0).payments;
        List<Enrolment__c> enrolments = new List<Enrolment__c>();
        List<String> unenroledStudents = new List<String>();
        
        //start of logic

        //end of logic
        
        //parse outputs
        CSVDataHandlerResult result = new CSVDataHandlerResult();
        result.enrolments = enrolments;
        result.unenroledStudents = unenroledStudents;
        List<CSVDataHandlerResult> resultList = new List<CSVDataHandlerResult>();
        resultList.add(result);
        return resultList;
    }
    
    
    public class EnrolmentsRequest{
        
        @InvocableVariable
        public List<Account> students;

        @InvocableVariable
        public List<Class__c> classes;
        
        @InvocableVariable
        public List<Payment__c> payments;
    }
    
    public class CSVDataHandlerResult{
        @InvocableVariable
        public List<Enrolment__c> enrolments;
        
        @InvocableVariable
        public List<String> unenroledStudents;
    }

}