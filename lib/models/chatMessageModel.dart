class chatMessageModel {
  String messageContent ; 
  String timestamp  ;
  String senderEmail; 
  bool isUser ;
  String day ; 
  chatMessageModel({required this.messageContent, required this.timestamp, required this.senderEmail, required this.isUser , required this.day } );
}