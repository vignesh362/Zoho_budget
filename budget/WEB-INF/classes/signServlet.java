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

public class signServlet extends HttpServlet {
	
private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)  {
		
		response.setContentType("Text/html");

		
		String a=request.getParameter("Uname");
		String b=request.getParameter("Uemail");
		String c=request.getParameter("Upass");
		String d=request.getParameter("Upass1");
		int p=0;
		String tbname = "User";	
		Connection conn = null;
		DataSet ds = null;
		if(c.equals(d)){
		try
		{
			//Add data in table
			Persistence per= (Persistence)BeanUtil.lookup("Persistence");
			Row row = new Row("User");
			row.set("Name",a);
			row.set("Email",b);
			row.set("Pass",c);
			DataObject data = new WritableDataObject();
			data.addRow(row);
			per.add(data);
			response.sendRedirect("index.html");

		}
		catch(Exception e)
	        {
			e.printStackTrace();
		}
	
		
			
	}
	
	}
	}

	

