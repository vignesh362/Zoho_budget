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
public class graph2 extends HttpServlet {
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
          month = month+1;
          String url="jdbc:mysql://localhost:3306/complaint";
          String sname="root";
          String spass="";
          HttpSession session=request.getSession();  
          String t="SELECT payment_method.name, SUM(expense.amount) as tot FROM expense left join payment_method on payment_method.Paymentmethod_id = expense.Paymentmethod_id where month(expense.date)="+month+" and expense.User_id="+session.getAttribute("ID")+" and year(expense.date)= "+year+" GROUP BY expense.Paymentmethod_id ";
        //  System.out.println("query probs:"+t);
          Class.forName("com.mysql.jdbc.Driver");
          Connection con=DriverManager.getConnection(url,sname,spass);
          PreparedStatement st=con.prepareStatement(t);
        	System.out.println(t);
          ResultSet rs=st.executeQuery();

          while(rs.next())
	          {	basic.add(rs.getString("Name"));
                basic.add(Integer.toString(rs.getInt("tot")));
              }
         
         
                response.getWriter().print(basic);
                //response.sendRedirect("homepage.jsp");
         
             
        
        } catch (Exception e) {
          System.out.println(e);
          }
               
	}   
   

}
