public class MockGetDataFromContact {
    public class NoDataFoundException extends Exception {}

    public static List<Contact> getDataFromContact() {
        throw new NoDataFoundException('An error occurred while fetching contacts.');
    }
}