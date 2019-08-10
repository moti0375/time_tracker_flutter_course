class ApiPath{
  static String job(String uid, String jobId) => "users/$uid/jobs/$jobId";
  static String jobs(String uid) => "users/$uid/jobs";
  static String entry(String uid, String entryId) => "user/$uid/entries/$entryId";
  static String entries(String uid) => "user/$uid/entries";
}