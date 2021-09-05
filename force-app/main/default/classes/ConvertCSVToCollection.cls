public with sharing class ConvertCSVToCollection {

    @invocableMethod(label='CSV Attachment to Record Collection' description='Take a CSV file attachment and parse the rows into an apex defined object to be processed in a Flow' category='Data Manipulation')
    public static List<ParseResult> createCSVCollection(List<ParseRequest> request){

        Attachment csvFile = request.get(0).csvFile;
        List<String> csvRows = new List<String>();
        List<CSVDataObject> csvRecords = new List<CSVDataObject>();


        // logic here.... 
        csvRows = (csvFile.Body==null?'':csvFile.Body.toString()).split('\n'); //String collection where csv body is converted to string and split into rows            
        csvRows.remove(0); // Remove first row (column headers) 

        for (String row : csvRows) {

            String[] csvRecordString = row.split(',');
            
            CSVDataObject csvRecord = new CSVDataObject();
            
            csvRecord.column01 	= csvRecordString[0];
            csvRecord.column02 	= csvRecordString[1];
            csvRecord.column03	= csvRecordString[2];
            csvRecord.column04	= csvRecordString[3];
            csvRecord.column05	= csvRecordString[4];
            csvRecord.column06 	= csvRecordString[5];
            csvRecord.column07	= csvRecordString[6];
            csvRecord.column08	= csvRecordString[7];
            csvRecord.column09	= csvRecordString[8]; 
            
            csvRecords.add(csvRecord);
                
        }


        ParseResult result = new ParseResult();
        result.csvRecords = csvRecords;
        List<ParseResult> resultList = new List<ParseResult>();
        resultList.add(result);
        return resultList;

    }

    // Flow Input
    public class ParseRequest { 
        @invocableVariable(label='CSV Attachment')
        public Attachment csvFile;
    }

    // Flow Output
    public class ParseResult {
        @invocableVariable (label='CSV Record Collection')
        public List<CSVDataObject> csvRecords;
    }


}


/*



        List<Response> responseList = new List<Response>();
        for (Request curRequest : requests) {

            Response response = new Response();
            response.csvRecords=new List<CSVDataObject>();
            

                            



                            Blob csvBlob;
                            csvBlob = csvFile.Body;
                            String csvString;

                            csvRows = (csvFile.Body==null?'':csvFile.Body.toString()).split('\n'); //String collection where csv body is converted to string and split into rows
                            response.csvHeaders=csvRows[0].split(',');              
                            csvRows.remove(0); // Remove first row (column headers) 
                          
                
                            List<CSVDataObject> csvRecords = new List<CSVDataObject>();

                            //Loop though each row from the csv 
                            
                            for (String row : csvRows) {
                                response.csvRecords.add(new CSVDataObject(response.csvHeaders, row));
                                //Split the columns and add to a collection 
                                //check the output, further processing might be needed before splitting the columns 
                                String[] csvRecordString = row.split(',');
                                
                                CSVDataObject csvRecord = new CSVDataObject();
                                
                                    csvRecord.column01 	= csvRecordString[0]; // Column #1 from the csv file
                                    csvRecord.column02 	= csvRecordString[1]; // Column #2 from the csv file 
                                    csvRecord.column03	= csvRecordString[2]; // etc etc 
                                    csvRecord.column04	= csvRecordString[3];
                                    csvRecord.column05	= csvRecordString[4];
                                    csvRecord.column06 	= csvRecordString[5];
                                    csvRecord.column07	= csvRecordString[6];
                                    csvRecord.column08	= csvRecordString[7];
                                    csvRecord.column09	= csvRecordString[8];
                                
                                csvRecords.add(csvRecord);
                                    
                            }

                        // Flow Action Logic End

                        

            responseList.add(response);
        }

        return responseList;
    }

    

}


*/