using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CpDashboard
{
    public partial class Arraylistjavascript : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ArrayList list = new ArrayList();
            list.Add("test1");
            list.Add("test2");
            HiddenField11.Value = ArrayListToString(ref list);

        }
        private string ArrayListToString(ref ArrayList _ArrayList)
        {
            int intCount;
            string strFinal = "";

            for (intCount = 0; intCount <= _ArrayList.Count - 1; intCount++)
            {
                if (intCount > 0)
                {
                    strFinal += "~";
                }

                strFinal += _ArrayList[intCount].ToString();
            }

            return strFinal;
        }
    }
}