using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using Newtonsoft.Json;
using MySql.Data.MySqlClient;

namespace Practice
{
    public partial class API : System.Web.UI.Page
    {
        public string data = "";
        public string condition = "";
        public string whereclause = "WHERE empdept.empdept_is_deleted = '0' ";
        public string andclause = "";
        public string error = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            data = Request.QueryString.ToString();
            string[] multiplereq = data.Split('&');
            //if (multiplereq[0] == "")
            //{
            //    whereclause = "";
            //    andclause = "";
            //}
            //else if (multiplereq.Length == 1)
            //{
            //    whereclause = "WHERE";
            //    andclause = "";
            //}
            //else if (multiplereq.Length > 1)
            //{
            //    whereclause = "WHERE";
            //}
            for (int i = 0; i < multiplereq.Length; i++)
            {
                string[] req = multiplereq[i].Split('=');
                if (req[0] == "")
                {
                    condition = "";
                }
                else if (req[0] == "emp_name")
                {
                    condition += " AND employee.emp_name = '" + req[1] + "' ";
                }
                else if (req[0] == "phone")
                {
                    condition += " AND employee.phone = '" + req[1] + "' ";
                }
                else if (req[0] == "subject")
                {
                    condition += " AND employee.subject = '" + req[1] + "' ";
                }
                else if (req[0] == "is_active")
                {
                    condition += " AND employee.is_active = '" + req[1] + "' ";
                }
                else if (req[0] == "dept_name")
                {
                    condition += " AND department.dept_name = '" + req[1] + "' ";
                }
                else if (req[0] == "city_name")
                {
                    condition += " AND city.city_name = '" + req[1] + "' ";
                }
                else if (req[0] == "dept_is_deleted")
                {
                    condition += " AND department.dept_is_deleted = '" + req[1] + "' ";
                }
                else if (req[0] == "city_is_deleted")
                {
                    condition += " AND city.city_is_deleted = '" + req[1] + "' ";
                }
                else
                {
                    error = "yes";
                }
                andclause = "AND";
            }
            Response.ContentType = "json";
            Response.Write(Data());
            Response.End();
        }

        public class columns
        {
            public string emp_name { get; set; }
            public string phone { get; set; }
            public string subject { get; set; }
            public string is_active { get; set; }
            public string dept_name { get; set; }
            public string city_name { get; set; }
            public string dept_is_deleted { get; set; }
            public string city_is_deleted { get; set; }
            public string emp_joining_time { get; set; }
            public string emp_deleted_time { get; set; }
        }

        public string Data()
        {
            string json = "";
            try
            {
                System.Globalization.CultureInfo provider = new System.Globalization.CultureInfo("en-US");
                if (error == "yes")
                {
                    json = "Enter valid key";
                    return json;
                }
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "SELECT employee.emp_id,employee.emp_name,employee.phone,employee.subject,employee.is_active,GROUP_CONCAT(empdept.dept_id SEPARATOR '&') AS dept_id,empdept.id,GROUP_CONCAT(department.dept_name SEPARATOR '&') AS dept_name,GROUP_CONCAT(department.dept_is_deleted SEPARATOR '&') AS dept_is_deleted,city.city_id,city.city_name,city.city_is_deleted,GROUP_CONCAT(empdept.empdept_is_deleted SEPARATOR '&') AS empdept_is_deleted,employee.emp_joining_time,employee.emp_deleted_time FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id " + whereclause + " " + condition + " GROUP BY empdept.emp_id;";
                con.Open();
                MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                var arlist = new ArrayList();
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    string deletedatestring = dr["emp_deleted_time"].ToString();
                    string joindatestring = dr["emp_joining_time"].ToString();
                    var deleted_time = "";
                    var joining_time = "";
                    if (joindatestring == "")
                    {
                        joining_time = "";
                    }
                    else
                    {
                        DateTime date = DateTime.Parse(joindatestring);
                        joining_time = date.ToString("MM-dd-yyyy hh:mm tt");
                    }
                    if (deletedatestring == "")
                    {
                        deleted_time = "";
                    }
                    else
                    {
                        DateTime date = DateTime.Parse(deletedatestring);
                        deleted_time = date.ToString("MM-dd-yyyy hh:mm tt");
                    }
                    arlist.Add(new columns { emp_name = dr["emp_name"].ToString(), phone = dr["phone"].ToString(), subject = dr["subject"].ToString(), is_active = dr["is_active"].ToString(), dept_name = dr["dept_name"].ToString(), city_name = dr["city_name"].ToString(), dept_is_deleted = dr["dept_is_deleted"].ToString(), city_is_deleted = dr["city_is_deleted"].ToString(), emp_joining_time = joining_time, emp_deleted_time = deleted_time }); //DateTime.Parse(dr["emp_deleted_time"].ToString()).ToString("MM-dd-yyyy hh:mm tt")
                }
                json = JsonConvert.SerializeObject(arlist);
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return json;
        }
    }
}