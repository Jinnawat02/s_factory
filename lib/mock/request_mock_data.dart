class RequestMockData {
  // A global list storing all maintenance requests
  static final List<Map<String, dynamic>> requests = [];

  // Function to add a new request to the mock data
  static void addRequest(Map<String, dynamic> requestData) {
    requests.add(requestData);
  }
}
