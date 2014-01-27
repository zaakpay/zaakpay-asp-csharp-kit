using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Text;
using System.Security.Cryptography;
using System.Collections.Specialized;
using System.IO;

namespace Checksum
{
    public class ParamSanitizer
    {
        public static string sanitizeParam(string param)
        {

            String ret = null;
            if (param == null)
                return null;

            ret = param.Replace("[>><>(){}?&* ~`!#$%^=+|\\:'\";,\\x5D\\x5B]+", " ");

            return ret;
        }

        public static String SanitizeURLParam(String url)
        {

            if (url == null)
                return "";

            Match match = Regex.Match(url, "^(https?)://[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|]", RegexOptions.IgnoreCase);

            if (match.Success)

                return url;
            else
                return "";

        }

    }


    public class ChecksumCalculator
    {
        public static string toHex(byte[] bytes)
        {
            StringBuilder hex = new StringBuilder(bytes.Length * 2);
            foreach (byte b in bytes)
                hex.AppendFormat("{0:x2}", b);
            return hex.ToString();


        }

        public static string calculateChecksum(string secretkey, string allparamvalues)
        {

            byte[] dataToEncryptByte = Encoding.UTF8.GetBytes(allparamvalues);
            byte[] keyBytes = Encoding.UTF8.GetBytes(secretkey);
            HMACSHA256 hmacsha256 = new HMACSHA256(keyBytes);
            byte[] checksumByte = hmacsha256.ComputeHash(dataToEncryptByte);
            String checksum = toHex(checksumByte);

            return checksum;
        }

        public static Boolean verifyChecksum(String secretKey, String allParamVauleExceptChecksum, String checksumReceived)
        {

            byte[] dataToEncryptByte = Encoding.UTF8.GetBytes(allParamVauleExceptChecksum);
            byte[] keyBytes = Encoding.UTF8.GetBytes(secretKey);
            HMACSHA256 hmacsha256 = new HMACSHA256(keyBytes);
            byte[] checksumCalculatedByte = hmacsha256.ComputeHash(dataToEncryptByte); ;
            String checksumCalculated = toHex(checksumCalculatedByte);

            if (checksumReceived.Equals(checksumCalculated))
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        public static string getAllNotEmptyParamValue(HttpRequest Request)
        {
            String allNonEmptyParamValue = "";
            // System.Text.StringBuilder displayValues = new System.Text.StringBuilder();

            NameValueCollection postedValues = Request.Form;
            String paramName;

            for (int i = 0; i < postedValues.AllKeys.Length; i++)
            {
                paramName = postedValues.AllKeys[i];


                String paramValue = ParamSanitizer.sanitizeParam(Request.Form.Get(paramName));

                if (paramValue != null)
                {
                    allNonEmptyParamValue = allNonEmptyParamValue + "'" + paramValue + "'";

                }

            }

            return allNonEmptyParamValue;

        }
    }

}
public partial class posttozaakpay : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}