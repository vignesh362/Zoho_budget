package abc;



import java.sql.*;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;  

class mail
{
    private static void run() {
    	 try {
        System.out.println("Running: " + new java.util.Date());
        String url="jdbc:mysql://localhost:3306/complaint";
        String sname="root";
        String spass="";
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
        LocalDateTime now = LocalDateTime.now();  
        String qu="select * from recurr_exp left join user on recurr_exp.user_id=user.user_id where date='"+dtf.format(now)+"'";
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection(url,sname,spass);
        PreparedStatement stmt=con.prepareStatement(qu);
       // System.out.println(qu);
  
        ResultSet rr=stmt.executeQuery();     
      while(rr.next()){
        // Recipient's email ID needs to be mentioned.
        String to = rr.getString("Email"); 
        System.out.println(to);

        // Sender's email ID needs to be mentioned
        String from ="vigneshextra1@gmail.com";
        final String username = "vigneshextra1@gmail.com";//change accordingly
        final String password = "Vignesh3523";//change accordingly

        // Assuming you are sending email through relay.jangosmtp.net
        String host = "smtp.gmail.com";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");

        // Get the Session object.
        Session session = Session.getInstance(props,
           new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                 return new PasswordAuthentication(username, password);
  	   }
           });

       
  	   // Create a default MimeMessage object.
  	   Message message = new MimeMessage(session);
  	
  	   // Set From: header field of the header.
  	   message.setFrom(new InternetAddress(from));
  	
  	   // Set To: header field of the header.
  	   message.setRecipients(Message.RecipientType.TO,
                 InternetAddress.parse(to));
  	
  	   // Set Subject: header field
  	   message.setSubject("Testing Subject");
  	   
  	
  	   // Now set the actual message
  	   message.setText("Hello "+rr.getString("name") + ",Recurring expense of amount " +rr.getString("amount")+
  		"pay it!!!! ");

  	   // Send message
  	   Transport.send(message);

  	   System.out.println("Sent message successfully....");

        } 
      }catch(Exception e)
    	 {
    	  System.out.println(e);
    	 }
    }
 
    public static void main(String[] args)
    {
        ScheduledExecutorService executorService;
        executorService = Executors.newSingleThreadScheduledExecutor();
        executorService.scheduleAtFixedRate(mail::run, 0, 60, TimeUnit.SECONDS);
    }
}
