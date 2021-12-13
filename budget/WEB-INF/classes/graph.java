import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;  
import javax.servlet.http.*; 
/**
 * Servlet implementation class graph1
 */
public class graph extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unchecked")
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
       
        ArrayList<String> basic=new ArrayList<String>();
        int amt=0;
        int exp=0;
        String mname[]={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        int m=0;
        
        // JSONArray fulldata = new JSONArray();   
          try{   
          int month;
          GregorianCalendar date = new GregorianCalendar();      
          month = date.get(Calendar.MONTH);
          int year=date.get(Calendar.YEAR);
          m=month;
          month = month+2;
          String url="jdbc:mysql://localhost:3306/complaint";
          String sname="root";
          String spass="";
          int temp=4;      
        while(temp>0){
          JSONObject gdata=new JSONObject();    
          month=month-1;
        if(month==0)
        {
                month=12;
                year=year-1;
        }
          HttpSession session=request.getSession();  
          String t="select sum(Amount) as amount from income where month(date)="+month+" and year(date)="+year+" and User_id="+session.getAttribute("ID");
          String t2="select sum(Amount) as amount from expense where month(date)="+month+" and year(date)="+year+" and User_id="+session.getAttribute("ID");
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(url,sname,spass);
          PreparedStatement st=con.prepareStatement(t);
          PreparedStatement st2=con.prepareStatement(t2); 
        	// System.out.println(t);
          // System.out.println(t2);
          ResultSet rs=st.executeQuery();
          ResultSet rs2=st2.executeQuery();

          if(rs.next())
	          	amt=rs.getInt("amount");
          if(rs2.next())
	          	exp=rs2.getInt("amount");
         //System.out.println(Integer.toString(amt)+" "+Integer.toString(exp)+"amt and exp"+mname[month-1]);
          // gdata.put("month",mname[month-1]); 
          // gdata.put("amt",Integer.toString(amt)); 
          // gdata.put("exp",Integer.toString(exp)); 
          // gdata.put("sav",Integer.toString(amt-exp)); 
         
         basic.add(mname[month-1]);
        basic.add(Integer.toString(amt));
        basic.add(Integer.toString(exp));
        basic.add(Integer.toString(amt-exp));
        //  System.out.println(gdata);
        //  fulldata.put(gdata);
         --temp;
         
           }
    
          response.getWriter().print(basic);
          //response.sendRedirect("homepage.jsp");
        
        } catch (Exception e) {
          System.out.println(e);
          }
               
	}   
   

}
