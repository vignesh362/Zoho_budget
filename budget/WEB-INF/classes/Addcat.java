import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import java.sql.*;
import com.adventnet.persistence.*;
import java.io.PrintWriter;
import com.adventnet.db.api.RelationalAPI;
import java.util.Iterator;
import java.util.*;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;  

public class Addcat extends HttpServlet {
	
private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("Text/html");
		String a=(String)request.getParameter("custId");
		String b=request.getParameter("name");
		String c=request.getParameter("comm");
       
		HttpSession session=request.getSession();
		//int e=Integer.parseInt(session.getAttribute("ID"));
		System.out.println(a+b+c);
        String tbname1 = "Income_type";	
        String tbname2 = "bcategory";
        System.out.println(a+"abcabcabcabcabcabcabcabc");

		try
		{
            Persistence per= (Persistence)BeanUtil.lookup("Persistence");
            RelationalAPI relapi = RelationalAPI.getInstance();
            java.sql.Connection con = null;
            con = relapi.getConnection();
			if(a.equals("1")){
            System.out.println(a+"came in");
            Row row = new Row(tbname1);
			row.set("Source",b);
            row.set("Comments",c);
            row.set("User_id",session.getAttribute("ID"));
			DataObject data = new WritableDataObject();
			data.addRow(row);
			per.add(data);
            }
            else{
                System.out.println(a+"else cam ikn");
                Row row = new Row(tbname2);
                row.set("Name",b);
                row.set("Comments",c);
                row.set("User_id",session.getAttribute("ID"));
                DataObject data = new WritableDataObject();
                data.addRow(row);
                per.add(data);
          
            }
			response.sendRedirect("homepage.jsp");
			// response.getWriter().println("<meta http-equiv='refresh' content='0;URL=homepage.jsp'>");
			// response.getWriter().println("<script>  alert(\"Successfully Added !\");</script>");
		}
		catch(Exception e1)
	        {
			e1.printStackTrace();
			response.getWriter().println("<meta http-equiv='refresh' content='0;URL=homepage.jsp'>");
			response.getWriter().println("<script>  alert(\"Error !\");</script>");
		}
	
		
			
	
	
	}
	}

	

