public with sharing class tg_ConvertCSVToCollection {

    // class fileColumn {
    //     @AuraEnabled
    //     Public String name {get; set;}
    //     @AuraEnabled
    //     Public String value {get; set;}
    //     public fileColumn(String name, String value) {
    //         this.name=name;
    //         this.value=value;
    //     }
    // }

    class fileRow {
        @AuraEnabled
        public Map<String, String> columns {get; set;}
        public fileRow(List<String> headers, String row) {
            columns=new Map<String, String>();
            List<String> values=row.split(',');
            for (Integer counter=0; counter<headers.size(); counter++) columns.put(headers[counter], values[counter]);
        }
    }

    public String getColumnFrom(Map<String, String> row, String header) {
        return row.get(header);
    }

    @invocableMethod(label='Convert Comma-separated-values to String Collection')
    public static List<Response> execute (List<Request> requests) {

        List<Response> responseList = new List<Response>();
        for (Request curRequest : requests) {

            Response response = new Response();
            response.csvRecordList=new List<fileRow>();
            
        
                        // Flow Action Logic Start

                            //Attachment csvFile = [SELECT Id,Name,Body FROM Attachment WHERE Id=:curRequest.attachmentId]; 
                            
                            Attachment      csvFile = new Attachment();
                            List<String>    csvRows = new List<String>();

                            Blob csvBlob;
                            csvBlob = csvFile.Body;
                            String csvString;

                            csvRows = (csvFile.Body==null?'':csvFile.Body.toString()).split('\n'); //String collection where csv body is converted to string and split into rows
                            response.csvHeaders=csvRows[0].split(',');              
                            csvRows.remove(0); // Remove first row (column headers) 
                          
                
                            // List<CSVDataObject> csvRecordList = new List<CSVDataObject>();

                            //Loop though each row from the csv 
                            
                            for (String row : csvRows) {
                                response.csvRecordList.add(new fileRow(response.csvHeaders, row));
                                //Split the columns and add to a collection 
                                //check the output, further processing might be needed before splitting the columns 
                                // String[] csvRecordString = row.split(',');
                                
                                // // CSVDataObject csvRecord = new CSVDataObject();
                                
                                //     csvRecord.column01 	= csvRecordString[0]; // Column #1 from the csv file
                                //     csvRecord.column02 	= csvRecordString[1]; // Column #2 from the csv file 
                                //     csvRecord.column03	= csvRecordString[2]; // etc etc 
                                //     csvRecord.column04	= csvRecordString[3];
                                //     csvRecord.column05	= csvRecordString[4];
                                //     csvRecord.column06 	= csvRecordString[5];
                                //     csvRecord.column07	= csvRecordString[6];
                                //     csvRecord.column08	= csvRecordString[7];
                                //     csvRecord.column09	= csvRecordString[8];
                                
                                // csvRecordList.add(csvRecord);
                                    
                            }

                        // Flow Action Logic End

                        

            responseList.add(response);
        }

        return responseList;
    }

    
    // Flow Action input variable(s)
    public class Request { 
        @invocableVariable(label='CSV Attachment')
        //public String attachmentId; 
        public Attachment csvFile;
    }

    // Flow Action output variable(s)
    public class Response {
        @invocableVariable (label='CSV Record Collection')
        public List<fileRow> csvRecordList; 
        @invocableVariable (label='CSV Record Headers')
        public List<String> csvHeaders; 


    }
}