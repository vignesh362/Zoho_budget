import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import java.sql.*;
import com.adventnet.persistence.*;
import java.io.*;
import com.adventnet.db.api.RelationalAPI;
import java.util.Iterator;
import java.util.*;
import java.time.format.DateTimeFormatter;  
import java.time.LocalDateTime;  

import org.json.JSONArray;
import org.json.JSONObject;
public class AddBudget extends HttpServlet {
	
private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		response.setContentType("Text/html");
		String str= request.getParameter("x");
		JSONObject obj = null;
		System.out.println(str);
		HttpSession session=request.getSession();
		String tbname = "Budget";	
		Connection conn = null;
        int bid=0;
		try
		{ 	RelationalAPI relapi = RelationalAPI.getInstance();
			java.sql.Connection con = null;
			con = relapi.getConnection();
			Persistence per= (Persistence)BeanUtil.lookup("Persistence");
			Row row = new Row(tbname);
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");  
            LocalDateTime now = LocalDateTime.now();  
            row.set("Created_on",dtf.format(now));
			row.set("User_id",session.getAttribute("ID"));
			DataObject data = new WritableDataObject();
			data.addRow(row);
			per.add(data);
			JSONArray array = new JSONArray(str);  
			for(int i=0; i < array.length(); i++)   
			{  
			JSONObject object = array.getJSONObject(i);  
			System.out.println(object.getString("id"));  
			System.out.println(object.getString("value"));  
			Row row2=new Row("Category_budget");
			row2.set("Category_id",object.getString("id"));
			row2.set("Amount",object.getString("value"));
			row2.set("Budget_id",row.get("Budget_id"));
			DataObject data2=new WritableDataObject();
			data2.addRow(row2);
			per.add(data2);
			}  
			
			
            }
			
		
		catch(Exception e1)
	        {
			System.out.println(e1);
			
		}
	
		
			
	
	
	}
	}

	

