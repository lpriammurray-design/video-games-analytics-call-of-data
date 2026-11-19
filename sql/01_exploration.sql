-- =============================================================
-- PROJET CALL OF DATA - 01. EXPLORATION DES DONNÉES
-- Problématique : Analyse des performances éditeurs
-- =============================================================


-- =============================================================
-- 1.1 EXPLORATION DE LA TABLE PLATEFORMES
-- =============================================================

-- Compter les lignes (31)
SELECT COUNT(*) AS Nbre_Lignes
FROM `BDD_Call_Of_Data.plateformes`;


-- Récupérer toutes les colonnes
SELECT *
FROM `BDD_Call_Of_Data.plateformes`;


-- Compter les valeurs NULL (pas de valeurs NULL)
SELECT
  COUNTIF(p.Platform IS NULL) AS Platform_ISNULL,
  COUNTIF(p.Nom_Complet IS NULL) AS Nom_Complet_ISNULL,
  COUNTIF(p.Constructeur IS NULL) AS Constructeur_ISNULL,
  COUNTIF(p.Type_Plateforme IS NULL) AS Type_Plateforme_ISNULL,
  COUNTIF(p.Generation IS NULL) AS Generation_ISNULL,
  COUNTIF(p.Annee_sortie_approximative IS NULL) AS Annee_sortie_approximative_ISNULL
FROM `BDD_Call_Of_Data.plateformes` AS p;


-- Identifier les doublons (pas de doublons détectés)
SELECT
  p.Platform,
  p.Nom_Complet,
  p.Constructeur,
  p.Type_Plateforme,
  p.Generation,
  p.Annee_sortie_approximative,
  COUNT(*) AS nb_lignes
FROM `BDD_Call_Of_Data.plateformes` AS p
GROUP BY
  p.Platform,
  p.Nom_Complet,
  p.Constructeur,
  p.Type_Plateforme,
  p.Generation,
  p.Annee_sortie_approximative
HAVING COUNT(*) > 1;


-- Vérifier le type des colonnes (pas d'incohérences)
SELECT column_name, data_type
FROM `BDD_Call_Of_Data.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'plateformes'
ORDER BY ordinal_position;


-- Vérifier les années (pas d'incohérences)
SELECT
  MIN(Annee_sortie_approximative) AS annee_min,
  MAX(Annee_sortie_approximative) AS annee_max
FROM `BDD_Call_Of_Data.plateformes`;


-- =============================================================
-- 1.2 EXPLORATION DE LA TABLE VENTES_SCORES
-- =============================================================

-- Compter les lignes
SELECT COUNT(*) AS Nbre_Lignes
FROM `BDD_Call_Of_Data.ventes_scores`;


-- Récupérer toutes les colonnes
SELECT *
FROM `BDD_Call_Of_Data.ventes_scores`;


-- Compter les valeurs NULL
SELECT
  COUNTIF(vs.Name IS NULL) AS Name_ISNULL,
  COUNTIF(vs.Platform IS NULL) AS Platform_ISNULL,
  COUNTIF(vs.Year_of_Release IS NULL) AS Year_Of_Release_ISNULL,
  COUNTIF(vs.Genre IS NULL) AS Genre_ISNULL,
  COUNTIF(vs.Publisher IS NULL) AS Publisher_ISNULL,
  COUNTIF(vs.NA_Sales IS NULL) AS NA_Sales_ISNULL,
  COUNTIF(vs.EU_Sales IS NULL) AS EU_Sales_ISNULL,
  COUNTIF(vs.JP_Sales IS NULL) AS JP_Sales_ISNULL,
  COUNTIF(vs.Other_Sales IS NULL) AS Other_Sales_ISNULL,
  COUNTIF(vs.Global_Sales IS NULL) AS Global_Sales_ISNULL,
  COUNTIF(vs.Critic_Score IS NULL) AS Critic_Score_ISNULL,
  COUNTIF(vs.Critic_Count IS NULL) AS Critic_Count_ISNULL,
  COUNTIF(vs.User_Score IS NULL) AS User_Score_ISNULL,
  COUNTIF(vs.User_Count IS NULL) AS User_Count_ISNULL,
  COUNTIF(vs.Developer IS NULL) AS Developer_ISNULL,
  COUNTIF(vs.Rating IS NULL) AS Rating_ISNULL
FROM `BDD_Call_Of_Data.ventes_scores` AS vs;


-- Compter les valeurs NULL en pourcentage en complément de la requête précédente
SELECT
  ROUND(COUNTIF(vs.Name IS NULL) / COUNT(*) * 100, 2) AS Name_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Platform IS NULL) / COUNT(*) * 100, 2) AS Platform_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Year_of_Release IS NULL) / COUNT(*) * 100, 2) AS Year_Of_Release_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Genre IS NULL) / COUNT(*) * 100, 2) AS Genre_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Publisher IS NULL) / COUNT(*) * 100, 2) AS Publisher_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.NA_Sales IS NULL) / COUNT(*) * 100, 2) AS NA_Sales_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.EU_Sales IS NULL) / COUNT(*) * 100, 2) AS EU_Sales_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.JP_Sales IS NULL) / COUNT(*) * 100, 2) AS JP_Sales_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Other_Sales IS NULL) / COUNT(*) * 100, 2) AS Other_Sales_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Global_Sales IS NULL) / COUNT(*) * 100, 2) AS Global_Sales_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Critic_Score IS NULL) / COUNT(*) * 100, 2) AS Critic_Score_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Critic_Count IS NULL) / COUNT(*) * 100, 2) AS Critic_Count_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.User_Score IS NULL) / COUNT(*) * 100, 2) AS User_Score_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.User_Count IS NULL) / COUNT(*) * 100, 2) AS User_Count_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Developer IS NULL) / COUNT(*) * 100, 2) AS Developer_ISNULL_pourcentage,
  ROUND(COUNTIF(vs.Rating IS NULL) / COUNT(*) * 100, 2) AS Rating_ISNULL_pourcentage
FROM `BDD_Call_Of_Data.ventes_scores` AS vs;


-- Afficher toutes les lignes où une valeur NULL est présente afin de voir le détail
SELECT *
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
WHERE
  vs.Name IS NULL
  OR vs.Platform IS NULL
  OR vs.Year_of_Release IS NULL
  OR vs.Genre IS NULL
  OR vs.Publisher IS NULL
  OR vs.NA_Sales IS NULL
  OR vs.EU_Sales IS NULL
  OR vs.JP_Sales IS NULL
  OR vs.Other_Sales IS NULL
  OR vs.Global_Sales IS NULL
  OR vs.Critic_Score IS NULL
  OR vs.Critic_Count IS NULL
  OR vs.User_Score IS NULL
  OR vs.User_Count IS NULL
  OR vs.Developer IS NULL
  OR vs.Rating IS NULL;


-- Identifier les doublons (doublons potentiels détectés : requête complémentaire ci-dessous à exécuter)
SELECT
  vs.Name,
  vs.Platform,
  vs.Year_of_Release,
  vs.Genre,
  vs.Publisher,
  COUNT(*) AS nb_lignes
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
GROUP BY
  vs.Name,
  vs.Platform,
  vs.Year_of_Release,
  vs.Genre,
  vs.Publisher
HAVING COUNT(*) > 1;


-- Suite au résultat précédent : vérification des deux occurrences complètes (pas de vrais doublons - ne pas supprimer)
SELECT *
FROM `BDD_Call_Of_Data.ventes_scores`
WHERE
  (Name IS NULL
   AND Platform = 'GEN'
   AND Year_of_Release = 1993
   AND Genre IS NULL
   AND Publisher = 'Acclaim Entertainment')
  OR
  (Name = 'Madden NFL 13'
   AND Platform = 'PS3'
   AND Year_of_Release = 2012
   AND Genre = 'Sports'
   AND Publisher = 'Electronic Arts')
ORDER BY
  Name,
  Platform;


-- Vérifier le type des colonnes (Year_of_Release en type FLOAT64)
SELECT column_name, data_type
FROM `BDD_Call_Of_Data.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'ventes_scores'
ORDER BY ordinal_position;


-- Vérification complémentaire pour la colonne Year_of_Release (à passer en INT64 dans l'étape CLEANING)
SELECT DISTINCT vs.Year_of_Release
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
ORDER BY vs.Year_of_Release;


-- Vérifier si des ventes sont négatives (aucune vente négative : OK)
SELECT *
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
WHERE
  vs.NA_Sales < 0
  OR vs.EU_Sales < 0
  OR vs.JP_Sales < 0
  OR vs.Other_Sales < 0
  OR vs.Global_Sales < 0;


-- Vérifier MIN et MAX du Critic_Score (OK : MIN 13 & MAX 98)
SELECT
  MIN(vs.Critic_Score) AS Critic_Score_MIN,
  MAX(vs.Critic_Score) AS Critic_Score_MAX
FROM `BDD_Call_Of_Data.ventes_scores` AS vs;


-- Vérifier MIN et MAX du User_Score (OK : MIN 0 & MAX 9,7)
SELECT
  MIN(vs.User_Score) AS User_Score_MIN,
  MAX(vs.User_Score) AS User_Score_MAX
FROM `BDD_Call_Of_Data.ventes_scores` AS vs;


-- =============================================================
-- 1.3 VÉRIFICATION D'INTÉGRITÉ ENTRE LES DEUX TABLES
-- =============================================================

-- Vérifier si toutes les valeurs Platform de ventes_scores existent dans plateformes
-- (Aucune donnée retournée : intégrité référentielle OK)
SELECT DISTINCT vs.Platform
FROM `BDD_Call_Of_Data.ventes_scores` AS vs
LEFT JOIN `BDD_Call_Of_Data.plateformes` AS p
  ON vs.Platform = p.Platform
WHERE p.Platform IS NULL;
