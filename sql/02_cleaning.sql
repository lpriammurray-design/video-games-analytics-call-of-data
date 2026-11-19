-- =============================================================
-- PROJET CALL OF DATA - 02. CLEANING & PRÉPARATION
-- Problématique : Analyse des performances éditeurs
-- =============================================================


-- Test de correction du type de Year_of_Release (FLOAT64 -> INT64) : Test OK
SELECT
  Year_of_Release,
  CAST(Year_of_Release AS INT64) AS Year_of_Release_clean
FROM `BDD_Call_Of_Data.ventes_scores`;


-- Création d'une table dénormalisée "call_of_data_complet" (LEFT JOIN sur Platform + typage Year_of_Release)
CREATE TABLE `BDD_Call_Of_Data.call_of_data_complet` AS
SELECT
  vs.Name,
  vs.Platform,
  CAST(vs.Year_of_Release AS INT64) AS Year_of_Release,
  vs.Genre,
  vs.Publisher,
  vs.NA_Sales,
  vs.EU_Sales,
  vs.JP_Sales,
  vs.Other_Sales,
  vs.Global_Sales,
  vs.Critic_Score,
  vs.Critic_Count,
  vs.User_Score,
  vs.User_Count,
  vs.Developer,
  vs.Rating,
  p.Nom_Complet,
  p.Constructeur,
  p.Type_Plateforme,
  p.Generation,
  p.Annee_sortie_approximative
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
LEFT JOIN `BDD_Call_Of_Data.plateformes` AS p
  ON vs.Platform = p.Platform;


-- Vérification du nombre de lignes de "call_of_data_complet" (OK : 16 719 lignes)
SELECT COUNT(*) AS Nbre_Lignes
FROM `BDD_Call_Of_Data.call_of_data_complet`;


-- Choix d'architecture pour Power BI :
-- Conserver les deux tables distinctes (ventes_scores_clean et plateformes)
-- afin d'optimiser le modèle relationnel, tout en corrigeant le type de Year_of_Release.

-- Création de la table nettoyée "ventes_scores_clean"
CREATE TABLE `BDD_Call_Of_Data.ventes_scores_clean` AS
SELECT
  Name,
  Platform,
  CAST(Year_of_Release AS INT64) AS Year_of_Release,
  Genre,
  Publisher,
  NA_Sales,
  EU_Sales,
  JP_Sales,
  Other_Sales,
  Global_Sales,
  Critic_Score,
  Critic_Count,
  User_Score,
  User_Count,
  Developer,
  Rating
FROM `BDD_Call_Of_Data.ventes_scores`;
