using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Proizvod.Models;
using Newtonsoft.Json.Linq;
using System.IO;

namespace Proizvod.Controllers
{
    public class ProizvodController : Controller
    {
        ProizvodDB dbhandle = new ProizvodDB();
        string path = @"C:\Users\Filip\Desktop\proizvodi.json";
        // GET: Proizvod
        public ActionResult Index(bool? db)
        {
           
            if (db == true)
            {
                var proizvodi = dbhandle.VratiProizvode();
                return View("IndexDB",proizvodi);
            }
            else
            {
            var webClient = new WebClient();
            var json = webClient.DownloadString(@"C:\Users\Filip\Desktop\proizvodi.json");
            var proizvodi = JsonConvert.DeserializeObject<Proizvodi>(json);
                return View(proizvodi);
            }
           
        }

       
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Proizvod/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Proizvod/Create
        [HttpPost]
        public ActionResult Create(ProizvodModel proizvod,bool? db)
        {
            try
            {
                if (db == true)
                {
                    if (ModelState.IsValid)
                    { 
                        if (dbhandle.DodajProizvod(proizvod))
                        {
                            ViewBag.Message = "Uspesno dodat proizvod.";
                            ModelState.Clear();    
                        }
                    }
                    return RedirectToAction("Index",new { db = true });
                }
                else
                {
                var webClient = new WebClient();
                var jsonData = System.IO.File.ReadAllText(path);
                var proizvodi = JsonConvert.DeserializeObject<Proizvodi>(jsonData);
                var poslednjiProizvod = proizvodi.proizvodi.LastOrDefault().ID;
                poslednjiProizvod++;
                proizvod.ID = poslednjiProizvod;
                proizvodi.proizvodi.Add(proizvod);
   
                jsonData = JsonConvert.SerializeObject(proizvodi);
                System.IO.File.WriteAllText(path, jsonData);
                return RedirectToAction("Index");
                }     
            }
            catch
            {
                return View();
            }
        }

        // GET: Proizvod/Edit/5
        public ActionResult Edit(int id,bool? db)
        {

            if (db == true)
            {
                var proizvodi = dbhandle.VratiProizvode();
                return View(proizvodi.Find(x => x.ID == id));
            }
            else
            {
                var webClient = new WebClient();
                var jsonData = System.IO.File.ReadAllText(path);
                var proizvodi = JsonConvert.DeserializeObject<Proizvodi>(jsonData);
                return View(proizvodi.proizvodi.Find(x => x.ID == id));
            }
        }

        // POST: Proizvod/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, ProizvodModel proizvod,bool? db)
        {
            try
            {
                if (db == true)
                {
                    dbhandle.EditProizvod(proizvod);
                    return RedirectToAction("Index", new { db = true });
                }
                else
                {

                    var jsonData = System.IO.File.ReadAllText(path);
                    var proizvodi = JsonConvert.DeserializeObject<Proizvodi>(jsonData);


                    for (int i = 0; i < proizvodi.proizvodi.Count; i++)
                    {
                        if (proizvodi.proizvodi[i].ID == proizvod.ID)
                        {
                            proizvodi.proizvodi[i] = proizvod;
                            break;
                        }
                    }
                    jsonData = JsonConvert.SerializeObject(proizvodi);
                    System.IO.File.WriteAllText(path, jsonData);

                    return RedirectToAction("Index");
                }      
            }
            catch
            {
                return View();
            }
        }

        

        
    }
}
