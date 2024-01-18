public class SalesforceCalloutForCalendar {
    public static void makeCallout(String selectedUserId, Date selectedDate) {
        String baseUrl = 'https://cittacoretechnologiesprivatelimit4--sacl1box.sandbox.lightning.force.com/services/apexrest/availableTimeSlotsService';

        // Encode parameters
        String encodedUserId = EncodingUtil.urlEncode(selectedUserId, 'UTF-8');
        String formattedDate = String.valueOf(selectedDate.year()) + '-' + String.valueOf(selectedDate.month()) + '-' + String.valueOf(selectedDate.day());
        String encodedDate = EncodingUtil.urlEncode(formattedDate, 'UTF-8');

        // Construct the full URL with parameters
        String url = baseUrl + '?selectedUserId=' + encodedUserId + '&selectedDate=' + encodedDate;

        // Create a new HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        // Set headers if needed (e.g., for authentication)
        // request.setHeader('Authorization', 'Bearer ' + accessToken);

        // Create a new HTTP object to send the request
        Http http = new Http();

        try {
            // Send the request and get the response
            HttpResponse response = http.send(request);

            // Check the response status
            if (response.getStatusCode() == 200) {
                // Successful callout
                String responseBody = response.getBody();
                System.debug('Response Body: ' + responseBody);
                // Process the response data as needed
            } else {
                // Error in the callout
                System.debug('Error in callout. Status Code: ' + response.getStatusCode());
                System.debug('Response: ' + response.getBody());
            }
        } catch (Exception e) {
            // Exception handling
            System.debug('Exception: ' + e.getMessage());
        }
    }
}