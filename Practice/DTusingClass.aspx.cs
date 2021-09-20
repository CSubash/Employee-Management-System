using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;

namespace Practice
{
    public partial class DTusingClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            public string buttons { get; set; }
            public string emp_joining_time { get; set; }
        }
        [WebMethod]
        public static string Table()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection conn = new MySqlConnection(connString);
                conn.Open();
                string queryStr = "SELECT employee.emp_id,employee.emp_name,employee.phone,employee.subject,employee.is_active,GROUP_CONCAT(empdept.dept_id SEPARATOR ',') AS dept_id,empdept.id,GROUP_CONCAT(department.dept_name SEPARATOR ',') AS dept_name,GROUP_CONCAT(department.dept_is_deleted SEPARATOR ',') AS dept_is_deleted,city.city_id,city.city_name,city.city_is_deleted,GROUP_CONCAT(empdept.empdept_is_deleted SEPARATOR ',') AS empdept_is_deleted,employee.emp_joining_time FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id WHERE empdept.empdept_is_deleted = '0' GROUP BY empdept.emp_id;";
                MySqlDataAdapter sda = new MySqlDataAdapter(queryStr, conn);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                var arlist = new ArrayList();
                StringBuilder html = new StringBuilder();
                int i = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    string datestring = dr["emp_joining_time"].ToString();
                    if (dt.Rows[i].Field<string>(4) == "y")
                    {
                        html.Append("<button type=\"button\" class=\"btn btn-warning dt-edit btn-sm\" data-toggle=\"modal\" data-target=\"#eeditmodal\" onclick=editbtn(" + dt.Rows[i].Field<int>(0) + ")><i class=\"fas fa-edit\"></i> Emp</button>    ");
                        html.Append("<button type='button' class='btn btn-danger dt-delete btn-sm' onclick=deletebtn('" + dt.Rows[i].Field<int>(0) + "') ><i class='fas fa-trash'></i> Emp</button>    ");
                    }
                    else
                    {
                        html.Append("<button type='button' class='btn btn-info dt-undo btn-sm' onclick=undoemp('" + dt.Rows[i].Field<int>(0) + "')><i class='fas fa-undo'></i> Emp</button>    ");
                    }

                    if (dt.Rows[i].Field<string>(11) == "1")
                    {
                        html.Append("<button type='button' class='btn btn-info dt-undocity btn-sm' onclick=undocity('" + dt.Rows[i].Field<int>(9) + "')><i class='fas fa-undo'></i> City</button>    ");
                    }
                    var length = dt.Rows[i].Field<string>(8).Split(',').Length;
                    for (int j = 0; j < length; j++)
                    {
                        if (dt.Rows[i].Field<string>(8).Split(',')[j] == "1")
                        {
                            html.Append("<button type='button' class='btn btn-info dt-undodept btn-sm' data-toggle='undodeptname' title='" + dt.Rows[i].Field<string>(7).Split(',')[j] + "(" + dt.Rows[i].Field<string>(5).Split(',')[j] + ")" + "' onclick=undodept('" + dt.Rows[i].Field<string>(5).Split(',')[j] + "')><i class='fas fa-undo'></i> Dept</button>    ");
                        }
                    }
                    i++;
                    if (datestring == "")
                    {
                        arlist.Add(new columns { emp_name = dr["emp_name"].ToString(), phone = dr["phone"].ToString(), subject = dr["subject"].ToString(), is_active = dr["is_active"].ToString(), dept_name = dr["dept_name"].ToString(), city_name = dr["city_name"].ToString(), dept_is_deleted = dr["dept_is_deleted"].ToString(), city_is_deleted = dr["city_is_deleted"].ToString(), buttons = html.ToString(), emp_joining_time = "" });
                    }
                    else
                    {
                        datestring = Convert.ToDateTime(datestring).ToString("MM-dd-yyyy hh:mm tt");
                        arlist.Add(new columns { emp_name = dr["emp_name"].ToString(), phone = dr["phone"].ToString(), subject = dr["subject"].ToString(), is_active = dr["is_active"].ToString(), dept_name = dr["dept_name"].ToString(), city_name = dr["city_name"].ToString(), dept_is_deleted = dr["dept_is_deleted"].ToString(), city_is_deleted = dr["city_is_deleted"].ToString(), buttons = html.ToString(), emp_joining_time = datestring });
                    }
                    html.Clear();
                }
                var output = JsonConvert.SerializeObject(arlist);
                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public static string Ddropdown()
        {
            var json = "";
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "SELECT dept_id,dept_name,dept_is_deleted FROM webappdemo.department";
                con.Open();
                MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                List<string> list = new List<string>();
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    list.Add(dr["dept_id"].ToString());
                    list.Add(dr["dept_name"].ToString());
                    list.Add(dr["dept_is_deleted"].ToString());
                }
                json = JsonConvert.SerializeObject(list);
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return json;
        }

        [WebMethod]
        public static string Cdropdown()
        {
            var json = "";
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "SELECT city_id,city_name,city_is_deleted FROM webappdemo.city";
                con.Open();
                MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                List<string> list = new List<string>();
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    list.Add(dr["city_id"].ToString());
                    list.Add(dr["city_name"].ToString());
                    list.Add(dr["city_is_deleted"].ToString());
                }
                json = JsonConvert.SerializeObject(list);
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return json;
        }

        [WebMethod]
        public static void Ecreate(dynamic ecnametext, dynamic ecphone, dynamic ecdeptid, dynamic ecdeptidcount, dynamic ecsubject, dynamic eccityid, dynamic time)
        {
            try
            {
                var a = "";
                var ecempid = "";
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "INSERT INTO webappdemo.employee (emp_name, phone, subject, is_active, city_id, emp_joining_time) VALUES ('" + ecnametext + "', '" + ecphone + "', '" + ecsubject + "', 'y', '" + eccityid + "', '" + time + "');";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
                con.Open();
                string queryy = "SELECT emp_id FROM webappdemo.employee ORDER BY emp_id DESC LIMIT 1";
                MySqlDataAdapter sda = new MySqlDataAdapter(queryy, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    ecempid = dr["emp_id"].ToString();
                }
                con.Close();
                for (int i = 0; i < ecdeptidcount; i++)
                {
                    a += "('" + ecempid + "','" + ecdeptid[i] + "','0','" + time + "'),";
                }
                a = a.TrimEnd(',');
                con.Open();
                string queryyy = "INSERT INTO webappdemo.empdept (emp_id,dept_id,empdept_is_deleted,empdept_created_time) VALUES " + a;
                MySqlCommand cmdd = new MySqlCommand(queryyy, con);
                cmdd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static string Eeditdetails(dynamic emp_id)
        {
            var json = "";
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "SELECT employee.emp_name,employee.phone,employee.subject,employee.emp_joining_time,empdept.id,GROUP_CONCAT(department.dept_name SEPARATOR ',') AS dept_name,city.city_name FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id  WHERE employee.emp_id = '" + emp_id + "' AND empdept.empdept_is_deleted = '0';";
                con.Open();
                MySqlDataAdapter sda = new MySqlDataAdapter(query, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                List<string> list = new List<string>();
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    list.Add(dr["emp_name"].ToString());
                    list.Add(dr["phone"].ToString());
                    list.Add(dr["subject"].ToString());
                    list.Add(dr["dept_name"].ToString());
                    list.Add(dr["city_name"].ToString());
                    list.Add(dr["id"].ToString());
                    if (dr["emp_joining_time"].ToString() == "")
                    {
                        list.Add(dr["emp_joining_time"].ToString());
                    }
                    else
                    {
                        list.Add(Convert.ToDateTime(dr["emp_joining_time"].ToString()).ToString("MM-dd-yyyy hh:mm tt"));
                    }
                }
                json = JsonConvert.SerializeObject(list);
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return json;
        }

        [WebMethod]
        public static void Eedit(dynamic eenametext, dynamic eephone, dynamic eesubject, dynamic eedeptid, dynamic eecityid, dynamic eename, dynamic pk, dynamic deptid, dynamic time, dynamic joiningtime)
        {
            try
            {
                var a = joiningtime.ToString();
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET employee.emp_name = '" + eenametext + "', employee.phone = '" + eephone + "', employee.subject =  '" + eesubject + "', employee.city_id = '" + eecityid + "', employee.emp_joining_time = '" + joiningtime + "' WHERE employee.emp_id = '" + eename + "'";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();

                deptid = deptid.Split(',');
                eedeptid = eedeptid.Split(',');
                var deptdel = new ArrayList();
                for (int i = 0; i < deptid.Length; i++)
                {
                    deptdel.Add(deptid[i]);
                }
                var deptadd = new ArrayList();
                for (int i = 0; i < eedeptid.Length; i++)
                {
                    deptadd.Add(eedeptid[i]);
                }

                var deptarlistdel = new ArrayList();
                for (var i = 0; i < deptdel.Count; i++)
                {
                    for (var j = 0; j < deptadd.Count; j++)
                    {
                        var dept_del = Convert.ToInt32(deptdel[i]);
                        var dept_add = Convert.ToInt32(deptadd[j]);
                        if (dept_del == dept_add)
                        {
                            deptarlistdel.Add(dept_del);
                        }
                    }
                }

                for (var i = 0; i < deptarlistdel.Count; i++)
                {
                    for (var j = 0; j < deptdel.Count; j++)
                    {
                        int deptarlist_del = Convert.ToInt32(deptarlistdel[i]);
                        int dept_del = Convert.ToInt32(deptdel[j]);
                        if (deptarlist_del == dept_del)
                        {
                            deptdel.RemoveAt(j);
                        }
                    }
                    for (var z = 0; z < deptadd.Count; z++)
                    {
                        int deptarlist_del = Convert.ToInt32(deptarlistdel[i]);
                        int dept_add = Convert.ToInt32(deptadd[z]);
                        if (deptarlist_del == dept_add)
                        {
                            deptadd.RemoveAt(z);
                        }
                    }
                }

                for (int i = 0; i < deptdel.Count; i++)
                {
                    con.Open();
                    string queryy = "UPDATE webappdemo.empdept SET empdept_is_deleted = '1', empdept_deleted_time = '" + time + "' WHERE dept_id = '" + deptdel[i] + "' AND emp_id = '" + eename + "'";
                    MySqlCommand cmdd = new MySqlCommand(queryy, con);
                    cmdd.ExecuteReader();
                    con.Close();
                }

                for (int i = 0; i < deptadd.Count; i++)
                {
                    con.Open();
                    string queryy = "INSERT INTO webappdemo.empdept (empdept_is_deleted, dept_id, emp_id, empdept_created_time) VALUES ('0','" + deptadd[i] + "','" + eename + "','" + time + "')";
                    MySqlCommand cmdd = new MySqlCommand(queryy, con);
                    cmdd.ExecuteReader();
                    con.Close();
                }

            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static string Edelete(dynamic emp_id, dynamic time)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET is_active = 'n', emp_deleted_time = '" + time + "' WHERE(emp_id = '" + emp_id + "')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return emp_id;
        }

        [WebMethod]
        public static void Undo(dynamic emp_id)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET is_active = 'y' , emp_deleted_time = NULL WHERE(emp_id = '" + emp_id + "')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void Dcreate(dynamic dcname)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "INSERT INTO webappdemo.department (dept_name,dept_is_deleted) VALUES ('" + dcname + "','0')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void Ddelete(dynamic ddname)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                con.Open();
                string query = "UPDATE webappdemo.department SET dept_is_deleted = '1' WHERE (department.dept_id = '" + ddname + "')";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void UndoDept(dynamic dept_id)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.department SET dept_is_deleted = '0' WHERE(dept_id = '" + dept_id + "')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void Ccreate(dynamic ccname)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "INSERT INTO webappdemo.city (city_name,city_is_deleted) VALUES ('" + ccname + "','0')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void Cdelete(dynamic cdname)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                con.Open();
                string query = "UPDATE webappdemo.city SET city_is_deleted = '1' WHERE (city.city_id = '" + cdname + "')";
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static void UndoCity(dynamic city_id)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.city SET city_is_deleted = '0' WHERE(city_id = '" + city_id + "')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

    }
}