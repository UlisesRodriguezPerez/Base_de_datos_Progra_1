﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using model.entity;
using model.neg;
using model.dao;

namespace CuentaDeAhorros.Controllers
{
    public class BeneficiarioController : Controller
    {
        private static int idB = 0;
        private BeneficiarioDao objetoBeneficiario;
        private TipoParentezcoDao objetoTipoParentezco;
        // GET: Beneficiarios

        public BeneficiarioController()
        {
            objetoBeneficiario = new BeneficiarioDao();
        }

        [HttpGet]
        public ActionResult Inicio(int Id)
        {
            List<Beneficiario> lista = objetoBeneficiario.findAllbeneficiariosPorCuenta(Id);
            //objetoBeneficiario. = name;
            return View(lista);
        }


        // GET: Beneficiarios/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Beneficiarios/Create
        [HttpGet]
        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Beneficiario beneficiario)
        {
            try
            {
              //  List<TipoParentezco> listaP = objetoTipoParentezco.getTiposParentezco();
                objetoBeneficiario.create(beneficiario);
                string id = objetoBeneficiario.findIdCuenta(beneficiario);
                return RedirectToAction("Inicio/" + id);
                
            }
            catch
            {
                return View();
            }
        }

        // GET: Beneficiarios/Edit/5
        [HttpGet]
        public ActionResult Update(int id)
        {
            Beneficiario objBeneficiario = new Beneficiario(id);
            objetoBeneficiario.find(objBeneficiario);
            return View(objBeneficiario);
        }

        // POST: Beneficiarios/Edit/5
        [HttpPost]
        public ActionResult Update(Beneficiario objBeneficiario, int ID)
        {
            try
            {
                
                objBeneficiario.IdBeneficiario = ID;
                objetoBeneficiario.update(objBeneficiario);
                string id = objetoBeneficiario.findIdCuenta(objBeneficiario);
                return RedirectToAction("Inicio/"+id);
            }
            catch
            {
                return View();
            }
        }

        // GET: Beneficiarios/Delete/5
        [HttpGet]
        public ActionResult Delete(Beneficiario objBeneficiario, int ID)
        {
            objBeneficiario.IdBeneficiario = ID;
            objetoBeneficiario.delete(objBeneficiario);
            return RedirectToAction("Inicio");
        }

        [HttpGet]
        public ActionResult Find(int Id)
        {
            idB = Id;
            Beneficiario objBeneficiario = new Beneficiario(Id);
            objetoBeneficiario.find(objBeneficiario);
            return View(objBeneficiario);
        }

        [HttpPost]
        public ActionResult Find(string ID)
        {
            return RedirectToAction("Inicio" + ID);
        }

        [HttpPost]
        public ActionResult FindAll(string ID)
        {
            return RedirectToAction("Inicio" + ID);
        }

        [HttpPost]
        public ActionResult VerifyPorcentaje(int porcent)
        {
            int porcentaje = Convert.ToInt32(porcent);
            if (porcentaje == 100) {
                return RedirectToAction("/Inicio/");
            }
            
            else
            {
                return RedirectToAction("/Inicio/");
            }
        }
    }
}
