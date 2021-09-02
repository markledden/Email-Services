public with sharing class CSVDataHandler {
    public CSVDataHandler() {

        String recordId; // This needs to be an invocable variable

        Attachment csvFile = [SELECT Id,Name,Body FROM Attachment WHERE Id=:recordId]; 


        String[] csvRows = csvFile.Body.toString().split('\n'); //String collection where csv body is converted to string and split into rows
        csvRows.remove(0); // Remove first row (column headers) 
        
        List<CSVDataObject> csvRecordList = new List<CSVDataObject>();
        
        //Loop though each row from the csv 
        for (String row : csvRows) {
            
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
            
            csvRecordList.add(csvRecord);
                
        }
    }
}
