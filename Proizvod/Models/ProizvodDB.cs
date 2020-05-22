using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Proizvod.Models
{
    public class ProizvodDB
    {
        private SqlConnection con;
        private void connection()
        {
            string constring = ConfigurationManager.ConnectionStrings["ProizvodConn"].ToString();
            con = new SqlConnection(constring);
        }

        
        public bool DodajProizvod(ProizvodModel proizvod)
        {
            connection();
            SqlCommand cmd = new SqlCommand("DodajProizvod", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Naziv", proizvod.Naziv);
            cmd.Parameters.AddWithValue("@Opis", proizvod.Opis);
            cmd.Parameters.AddWithValue("@Kategorija", proizvod.Kategorija);
            cmd.Parameters.AddWithValue("@Proizvodjac", proizvod.Proizvodjac);
            cmd.Parameters.AddWithValue("@Dobavljac", proizvod.Dobavljac);
            cmd.Parameters.AddWithValue("@Cena", proizvod.Cena);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();

            if (i >= 1)
                return true;
            else
                return false;
        }

     
        public List<ProizvodModel> VratiProizvode()
        {
            connection();
            List<ProizvodModel> proizvodi = new List<ProizvodModel>();

            SqlCommand cmd = new SqlCommand("VratiProizvode", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sd = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            con.Open();
            sd.Fill(dt);
            con.Close();

            foreach (DataRow dr in dt.Rows)
            {
                proizvodi.Add(
                    new ProizvodModel
                    {
                        ID = Convert.ToInt32(dr["ID"]),
                        Naziv = Convert.ToString(dr["Naziv"]),
                        Opis = Convert.ToString(dr["Opis"]),
                        Kategorija = Convert.ToString(dr["Kategorija"]),
                        Proizvodjac = Convert.ToString(dr["Proizvodjac"]),
                        Dobavljac = Convert.ToString(dr["Dobavljac"]),
                        Cena = Convert.ToDecimal(dr["Cena"])
                    });
            }
            return proizvodi;
        }

       
        public bool EditProizvod(ProizvodModel proizvod)
        {
            connection();
            SqlCommand cmd = new SqlCommand("UpdateProizvoda", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ID", proizvod.ID);
            cmd.Parameters.AddWithValue("@Naziv", proizvod.Naziv);
            cmd.Parameters.AddWithValue("@Opis", proizvod.Opis);
            cmd.Parameters.AddWithValue("@Kategorija", proizvod.Kategorija);
            cmd.Parameters.AddWithValue("@Proizvodjac", proizvod.Proizvodjac);
            cmd.Parameters.AddWithValue("@Dobavljac", proizvod.Dobavljac);
            cmd.Parameters.AddWithValue("@Cena", proizvod.Cena);

            con.Open();
            int i = cmd.ExecuteNonQuery();
            con.Close();

            if (i >= 1)
                return true;
            else
                return false;
        }

    }
}