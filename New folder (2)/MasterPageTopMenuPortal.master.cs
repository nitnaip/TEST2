using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class web_MasterPageTopMenuPortal : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["user_name"] = "SUTTHIWAT";//eosl
        Session["user_name"] = "PREECHANAN"; //manager
        Session["user_name"] = "SOONTHORNA";//employee-->senior
        Session["user_name"] = "JADET"; //employee-->senior
        Session["user_name"] = "SASIPIM";
        Session["user_name"] = "ADMIN";

        if (!IsPostBack)
        {
            try
            {
                try { string username = Session["user_name"].ToString(); } catch { Response.Redirect("login.aspx"); return; }

                imguser_show.Src = Session["user_img"].ToString();
                user_display_show.InnerText = Session["user_display"].ToString();

                check_role();
            }
            catch
            { Response.Redirect("login.aspx"); return; }
        }

    }
    private void check_role()
    {
        if (Session["role_type"].ToString() == "admin") { return; }
        string user_id = Session["user_name"].ToString();
        string sqlstr = @"select a.seq_role ,a.user_id,b.seq_menu_sub,lower(c.name) as menu_sub_name
                        ,case when c.seq_menu = 1 then 'admin' else 'dashboard' end  page_type
                        from  eols_m_role_user a
                        inner join  eols_m_role_menu b on a.seq_role = b.seq_role
                        inner join  eols_m_menu_sub c on  b.seq_menu_sub= c.seq 
                        inner join eols_m_role r on a.seq_role = r.seq and lower(r.status_active) = 'active'
                        where lower(a.user_id)  = lower('" + user_id + "')  ";

        DataTable dt = new DataTable();
        ClsConnection conn = new ClsConnection();
        conn.OpenConnection();
        dt = conn.ExecuteAdapter(sqlstr).Tables[0];
        conn.CloseConnection();

        page_labperformance.Attributes.Add("class", "d-none");
        page_kpi.Attributes.Add("class", "d-none");
        page_overtime.Attributes.Add("class", "d-none");
        page_budget.Attributes.Add("class", "d-none");
        page_producthighlight.Attributes.Add("class", "d-none");
        page_projectprogress.Attributes.Add("class", "d-none");
        page_benchmark.Attributes.Add("class", "d-none");
        page_competency.Attributes.Add("class", "d-none");

        try
        {
            Session["dtrole_menu"] = dt;
        }
        catch { }

        if (dt.Rows.Count > 0)
        {
            try
            {
                DataRow[] dr = dt.Select("page_type='admin'");
                if (dr.Length > 0)
                { menu_switch_role_type.Attributes.Add("class", "dropdown-item"); }
                else { menu_switch_role_type.Attributes.Add("class", "d-none"); }

            }
            catch { }
            string first_page = "";

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (i == 0) {
                    first_page = dt.Rows[i]["menu_sub_name"].ToString();
                }

                if (dt.Rows[i]["page_type"].ToString() != "dashboard") { continue; }
                switch (dt.Rows[i]["menu_sub_name"].ToString())
                {
                    case "lab performance overview":
                        page_labperformance.Attributes.Add("class", "");
                         
                        break;

                    case "kpi":
                        page_kpi.Attributes.Add("class", "");
                        break;

                    case "overtime control":
                        page_overtime.Attributes.Add("class", "");
                        break;

                    case "budget":
                        page_budget.Attributes.Add("class", "");
                        break;

                    case "product monitoring":
                        page_producthighlight.Attributes.Add("class", "");
                        break;

                    case "project progress":
                        page_projectprogress.Attributes.Add("class", "");
                        break;
                    case "benchmarking monitoring":
                        page_benchmark.Attributes.Add("class", "");
                        break;

                    case "competency":
                        page_competency.Attributes.Add("class", "");
                        break;
                }
            }

            //if (first_page != "") {
            //    Response.Redirect("login.aspx"); return;
            //}
        }
    }

}
