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

namespace EmployeeManagement
{
    public partial class DTusingClass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public class Columns
        {
            public string EmployeeName { get; set; }
            public string Phone { get; set; }
            public string Subject { get; set; }
            public string IsActive { get; set; }
            public string DepartmentName { get; set; }
            public string CityName { get; set; }
            public string DepartmentIsDeleted { get; set; }
            public string CityIsDeleted { get; set; }
            public string Buttons { get; set; }
            public string EmployeeJoiningTime { get; set; }
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
                var arrayList = new ArrayList();
                StringBuilder html = new StringBuilder();
                int count = 0;
                foreach (DataRow dr in dt.Rows)
                {
                    string datestring = dr["emp_joining_time"].ToString();
                    if (dt.Rows[count].Field<string>(4) == "y")
                    {
                        html.Append("<button type=\"button\" class=\"btn btn-warning dt-edit btn-sm\" data-toggle=\"modal\" data-target=\"#employeeEditModal\" onclick=EditButton(" + dt.Rows[count].Field<int>(0) + ")><i class=\"fas fa-edit\"></i> Emp</button>    ");
                        html.Append("<button type='button' class='btn btn-danger dt-delete btn-sm' onclick=DeleteButton('" + dt.Rows[count].Field<int>(0) + "') ><i class='fas fa-trash'></i> Emp</button>    ");
                    }
                    else
                    {
                        html.Append("<button type='button' class='btn btn-info dt-undo btn-sm' onclick=UndoEmployee('" + dt.Rows[count].Field<int>(0) + "')><i class='fas fa-undo'></i> Emp</button>    ");
                    }

                    if (dt.Rows[count].Field<string>(11) == "1")
                    {
                        html.Append("<button type='button' class='btn btn-info dt-undocity btn-sm' onclick=UndoCity('" + dt.Rows[count].Field<int>(9) + "')><i class='fas fa-undo'></i> City</button>    ");
                    }
                    var length = dt.Rows[count].Field<string>(8).Split(',').Length;
                    for (int j = 0; j < length; j++)
                    {
                        if (dt.Rows[count].Field<string>(8).Split(',')[j] == "1")
                        {
                            html.Append("<button type='button' class='btn btn-info dt-undodept btn-sm' data-toggle='undoDepartmentName' title='" + dt.Rows[count].Field<string>(7).Split(',')[j] + "(" + dt.Rows[count].Field<string>(5).Split(',')[j] + ")" + "' onclick=UndoDepartment('" + dt.Rows[count].Field<string>(5).Split(',')[j] + "')><i class='fas fa-undo'></i> Dept</button>    ");
                        }
                    }
                    count++;
                    if (datestring == "")
                    {
                        arrayList.Add(new Columns { EmployeeName = dr["emp_name"].ToString(), Phone = dr["phone"].ToString(), Subject = dr["subject"].ToString(), IsActive = dr["is_active"].ToString(), DepartmentName = dr["dept_name"].ToString(), CityName = dr["city_name"].ToString(), DepartmentIsDeleted = dr["dept_is_deleted"].ToString(), CityIsDeleted = dr["city_is_deleted"].ToString(), Buttons = html.ToString(), EmployeeJoiningTime = "" });
                    }
                    else
                    {
                        datestring = Convert.ToDateTime(datestring).ToString("MM-dd-yyyy hh:mm tt");
                        arrayList.Add(new Columns { EmployeeName = dr["emp_name"].ToString(), Phone = dr["phone"].ToString(), Subject = dr["subject"].ToString(), IsActive = dr["is_active"].ToString(), DepartmentName = dr["dept_name"].ToString(), CityName = dr["city_name"].ToString(), DepartmentIsDeleted = dr["dept_is_deleted"].ToString(), CityIsDeleted = dr["city_is_deleted"].ToString(), Buttons = html.ToString(), EmployeeJoiningTime = datestring });
                    }
                    html.Clear();
                }
                var output = JsonConvert.SerializeObject(arrayList);
                return output;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public static string DepartmentDropdown()
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
        public static string CityDropdown()
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
        public static void EmployeeCreate(dynamic employeeCreateName, dynamic employeeCreatePhone, dynamic employeeCreateDepartmentID, dynamic employeeCreateDepartmentIDCount, dynamic employeeCreateSubject, dynamic employeeCreateCityID, dynamic employeeJoiningTime)
        {
            try
            {
                var queryValues = "";
                var employeeID = "";
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query1 = "INSERT INTO webappdemo.employee (emp_name, phone, subject, is_active, city_id, emp_joining_time) VALUES ('" + employeeCreateName + "', '" + employeeCreatePhone + "', '" + employeeCreateSubject + "', 'y', '" + employeeCreateCityID + "', '" + employeeJoiningTime + "');";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query1, con);
                cmd.ExecuteReader();
                con.Close();
                con.Open();
                string queryy = "SELECT emp_id FROM webappdemo.employee ORDER BY emp_id DESC LIMIT 1";
                MySqlDataAdapter sda = new MySqlDataAdapter(queryy, con);
                DataSet ds = new DataSet();
                sda.Fill(ds, "results");
                foreach (DataRow dr in ds.Tables["results"].Rows)
                {
                    employeeID = dr["emp_id"].ToString();
                }
                con.Close();
                for (int i = 0; i < employeeCreateDepartmentIDCount; i++)
                {
                    queryValues += "('" + employeeID + "','" + employeeCreateDepartmentID[i] + "','0','" + employeeJoiningTime + "'),";
                }
                queryValues = queryValues.TrimEnd(',');
                con.Open();
                string query2 = "INSERT INTO webappdemo.empdept (emp_id,dept_id,empdept_is_deleted,empdept_created_time) VALUES " + queryValues;
                MySqlCommand cmdd = new MySqlCommand(query2, con);
                cmdd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        [WebMethod]
        public static string EmployeeEditDetails(dynamic employeeID)
        {
            var json = "";
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "SELECT employee.emp_name,employee.phone,employee.subject,employee.emp_joining_time,empdept.id,GROUP_CONCAT(department.dept_name SEPARATOR ',') AS dept_name,city.city_name FROM employee JOIN empdept ON employee.emp_id=empdept.emp_id JOIN city ON employee.city_id=city.city_id JOIN department ON empdept.dept_id=department.dept_id  WHERE employee.emp_id = '" + employeeID + "' AND empdept.empdept_is_deleted = '0';";
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
        public static void EmployeeEdit(dynamic employeeEditName, dynamic employeeEditNameText, dynamic employeeEditPhone, dynamic employeeEditDepartmentID, dynamic employeeEditSubject, dynamic employeeEditCityID, dynamic departmentID, dynamic time, dynamic joiningTime)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET employee.emp_name = '" + employeeEditNameText + "', employee.phone = '" + employeeEditPhone + "', employee.subject =  '" + employeeEditSubject + "', employee.city_id = '" + employeeEditCityID + "', employee.emp_joining_time = '" + joiningTime + "' WHERE employee.emp_id = '" + employeeEditName + "'";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();

                departmentID = departmentID.Split(',');
                employeeEditDepartmentID = employeeEditDepartmentID.Split(',');
                var departmentDeleteArrayList = new ArrayList();
                for (var i =0; i<departmentID.Length; i++)
                {
                    departmentDeleteArrayList.Add(departmentID[i]);
                }
                var departmentAddArrayList = new ArrayList();
                for (var i =0; i<employeeEditDepartmentID.Length; i++)
                {
                    departmentAddArrayList.Add(employeeEditDepartmentID[i]);
                }

                var departmentArrayListDelete = new ArrayList();
                for (var i=0; i<departmentDeleteArrayList.Count; i++)
                {
                    for (var j=0; j<departmentAddArrayList.Count; j++)
                    {
                        var deleteDepartment = Convert.ToInt32(departmentDeleteArrayList[i]);
                        var addDepartment = Convert.ToInt32(departmentAddArrayList[j]);
                        if (deleteDepartment == addDepartment)
                        {
                            departmentArrayListDelete.Add(deleteDepartment);
                        }
                    }
                }

                for (var i=0; i<departmentArrayListDelete.Count; i++)
                {
                    for (var j=0; j<departmentDeleteArrayList.Count; j++)
                    {
                        int deleteDepartmentInArrayList = Convert.ToInt32(departmentArrayListDelete[i]);
                        int deleteDepartment = Convert.ToInt32(departmentDeleteArrayList[j]);
                        if (deleteDepartmentInArrayList == deleteDepartment)
                        {
                            departmentDeleteArrayList.RemoveAt(j);
                        }
                    }
                    for (var z=0; z<departmentAddArrayList.Count; z++)
                    {
                        int deleteDepartmentInArrayList = Convert.ToInt32(departmentArrayListDelete[i]);
                        int addDepartment = Convert.ToInt32(departmentAddArrayList[z]);
                        if (deleteDepartmentInArrayList == addDepartment)
                        {
                            departmentAddArrayList.RemoveAt(z);
                        }
                    }
                }

                for (int i = 0; i < departmentDeleteArrayList.Count; i++)
                {
                    con.Open();
                    string queryy = "UPDATE webappdemo.empdept SET empdept_is_deleted = '1', empdeleteDepartmenteted_time = '" + time + "' WHERE dept_id = '" + departmentDeleteArrayList[i] + "' AND emp_id = '" + employeeEditName + "'";
                    MySqlCommand cmdd = new MySqlCommand(queryy, con);
                    cmdd.ExecuteReader();
                    con.Close();
                }

                for (int i = 0; i < departmentAddArrayList.Count; i++)
                {
                    con.Open();
                    string queryy = "INSERT INTO webappdemo.empdept (empdept_is_deleted, dept_id, emp_id, empdept_created_time) VALUES ('0','" + departmentAddArrayList[i] + "','" + employeeEditName + "','" + time + "')";
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
        public static string EmployeeDelete(dynamic employeeID, dynamic time)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET is_active = 'n', emp_deleted_time = '" + time + "' WHERE(emp_id = '" + employeeID + "')";
                con.Open();
                MySqlCommand cmd = new MySqlCommand(query, con);
                cmd.ExecuteReader();
                con.Close();
            }
            catch (Exception ex)
            {
                throw (ex);
            }
            return employeeID;
        }

        [WebMethod]
        public static void UndoEmployee(dynamic employeeID)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.employee SET is_active = 'y' , emp_deleted_time = NULL WHERE(emp_id = '" + employeeID + "')";
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
        public static void DepartmentCreate(dynamic departmentCreateName)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "INSERT INTO webappdemo.department (dept_name,dept_is_deleted) VALUES ('" + departmentCreateName + "','0')";
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
        public static void DepartmentDelete(dynamic departmentDeleteName)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                con.Open();
                string query = "UPDATE webappdemo.department SET dept_is_deleted = '1' WHERE (department.dept_id = '" + departmentDeleteName + "')";
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
        public static void UndoDepartment(dynamic departmentID)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.department SET dept_is_deleted = '0' WHERE(dept_id = '" + departmentID + "')";
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
        public static void CityCreate(dynamic cityCreateName)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "INSERT INTO webappdemo.city (city_name,city_is_deleted) VALUES ('" + cityCreateName + "','0')";
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
        public static void CityDelete(dynamic cityDeleteName)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                con.Open();
                string query = "UPDATE webappdemo.city SET city_is_deleted = '1' WHERE (city.city_id = '" + cityDeleteName + "')";
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
        public static void UndoCity(dynamic cityID)
        {
            try
            {
                string conString = ConfigurationManager.ConnectionStrings["WebAppConn"].ToString();
                MySqlConnection con = new MySqlConnection(conString);
                string query = "UPDATE webappdemo.city SET city_is_deleted = '0' WHERE(city_id = '" + cityID + "')";
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