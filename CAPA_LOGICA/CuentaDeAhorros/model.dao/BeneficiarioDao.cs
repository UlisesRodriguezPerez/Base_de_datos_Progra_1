﻿using model.entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace model.dao
{
    public class BeneficiarioDao : TemplateCRUD<Beneficiario>
    {

        //Atributos de la clase
        private Conexion objConexion;
        private SqlCommand comando;

        public BeneficiarioDao()
        {
            objConexion = Conexion.saberEstado();
        }

        public void create(Beneficiario beneficiario)
        {
            try
            {
                comando = new SqlCommand("SPInsertarBeneficiario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@pIdTipoParentezco", beneficiario.IdTipoParentezco);
                comando.Parameters.AddWithValue("@pIdPersona", beneficiario.IdPersona);
                comando.Parameters.AddWithValue("@pIdDeBeneficiario", beneficiario.IdCuenta);
                comando.Parameters.AddWithValue("@pPorcentaje ", beneficiario.Porcentaje);


                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
        }

        public void delete(Beneficiario beneficiario)
        {
            try
            {
                comando = new SqlCommand("SPEliminarLogicoBeneficiario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Id", beneficiario.IdBeneficiario);
                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
        }

        public bool find(Beneficiario objetoBeneficiario)
        {
            bool hayRegistros;
            try
            {
                comando = new SqlCommand("SPObtenerBeneficiario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Id", objetoBeneficiario.IdBeneficiario);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                hayRegistros = read.Read();
                if (hayRegistros)
                {
                    objetoBeneficiario.IdBeneficiario = Convert.ToInt32(read[0].ToString());
                    objetoBeneficiario.IdPersona = Convert.ToInt32(read[1].ToString());
                    objetoBeneficiario.IdTipoParentezco = Convert.ToInt32(read[2].ToString());
                    objetoBeneficiario.IdCuenta = Convert.ToInt32(read[3].ToString());
                    objetoBeneficiario.Porcentaje = Convert.ToInt32(read[4].ToString());
                }
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
            return hayRegistros;
        }

        public List<Beneficiario> findAll()
        {
            List<Beneficiario> listaBeneficiario = new List<Beneficiario>();
            return listaBeneficiario;
        }

        public List<Beneficiario> findAllbeneficiariosPorCuenta(int id)
        {
            List<Beneficiario> listaBeneficiario = new List<Beneficiario>();

            try
            {
                comando = new SqlCommand("SPObtenerBeneficiariosCuenta", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@idCuentaAhorro", id);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                while (read.Read())
                {

                    Beneficiario objetoBeneficiario = new Beneficiario
                    {
                        IdBeneficiario = Convert.ToInt32(read[0].ToString()),
                        IdPersona = Convert.ToInt32(read[1].ToString()),
                        IdTipoParentezco = Convert.ToInt32(read[2].ToString()),
                        IdCuenta = Convert.ToInt32(read[3].ToString()),
                        Porcentaje = Convert.ToInt32(read[4].ToString()),
                    };
                    listaBeneficiario.Add(objetoBeneficiario);
                }
            }

            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
            return listaBeneficiario;
        }


        public void update(Beneficiario beneficiario)
        {
            try
            {
                comando = new SqlCommand("SPActualizarBeneficiario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@pIdBeneficiario", beneficiario.IdBeneficiario);
                comando.Parameters.AddWithValue("@pIdPersona", beneficiario.IdPersona);
                comando.Parameters.AddWithValue("@pIdTipoParentezco", beneficiario.IdTipoParentezco);
                comando.Parameters.AddWithValue("@pIdCuenta", beneficiario.IdCuenta);
                comando.Parameters.AddWithValue("@pPorcentaje", beneficiario.Porcentaje);
                objConexion.getConexion().Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
        }
        public string findIdCuenta(Beneficiario objetoBeneficiario)
        {
            string indice;
            try
            {
                comando = new SqlCommand("SPObtenerIdCuentaBeneficiario", objConexion.getConexion());
                comando.CommandType = CommandType.StoredProcedure;
                comando.Parameters.AddWithValue("@Id", objetoBeneficiario.IdBeneficiario);
                objConexion.getConexion().Open();
                SqlDataReader read = comando.ExecuteReader();
                read.Read();
                indice = read[0].ToString();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }
            return indice;


        }

        public string verificar(Beneficiario objBeneficiario)
        {

            string result;
            try
            {


                if (objBeneficiario.Activo == true)
                {
                    result = "Admin";
                }

                else
                {
                    result = "Normal";
                }
            }


            catch (Exception)
            {
                throw;
            }
            finally
            {
                objConexion.getConexion().Close();
                objConexion.cerrarConexion();
            }

            return result;
        }

    }
}



