import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.adventnet.ds.query.*;
import com.adventnet.mfw.bean.BeanUtil;
import com.adventnet.persistence.*;
import java.io.PrintWriter;
import com.adventnet.db.api.RelationalAPI;
import java.util.Iterator;
import java.util.*;
public class logincheck extends HttpServlet {
	public logincheck() {}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		
		
		String a=(String)request.getParameter("Uemail");
		String b=(String)request.getParameter("Upass");
        DataObject d=null;
		String tableName="User";
		int tid=0;
		try {
			Table table = new Table(tableName);
			SelectQueryImpl selectQueryImpl = new SelectQueryImpl(table);
			Criteria ci1=new Criteria(new Column("User","Email"),a,0);
            Criteria ci2=new Criteria(new Column("User","Pass"),b,0);
            Criteria ci3=ci1.and(ci2);
			
			Column column = new Column(tableName, "*");
			selectQueryImpl.addSelectColumn(column);
			selectQueryImpl.setCriteria(ci3);
			Persistence per = (Persistence)BeanUtil.lookup("Persistence");
			d = per.get((SelectQuery)selectQueryImpl);
			Row row=d.getFirstRow(tableName);
			
			HttpSession session=request.getSession();
			session.setAttribute("ID",row.get(1));
			System.out.print(session.getAttribute("ID"));
			if(!d.isEmpty())
		{
			response.sendRedirect("homepage.jsp");
		
							
		}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("signup.html");
		}
		
			
		
	
	}

	
}
