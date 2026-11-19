-- =============================================================
-- PROJET CALL OF DATA - 03. ANALYSE MÉTIER
-- Problématique : Analyse des performances éditeurs
-- =============================================================


-- =============================================================
-- 3.1 ANALYSES PAR VENTES
-- =============================================================

-- Nombre de jeux distincts
SELECT
  COUNT(DISTINCT Name) AS nb_jeux
FROM `BDD_Call_Of_Data.ventes_scores_clean`;


-- Nombre d'éditeurs distincts
SELECT
  COUNT(DISTINCT Publisher) AS nb_editeurs
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL;


-- Ventes mondiales totales de jeux (en millions)
SELECT
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean`;


-- Top 10 éditeurs par ventes mondiales de jeux
SELECT
  Publisher,
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY ventes_mondiales_millions DESC
LIMIT 10;


-- Top 1 éditeur par ventes mondiales de jeux
SELECT
  Publisher,
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY ventes_mondiales_millions DESC
LIMIT 1;


-- Ventes mondiales de jeux par genre
SELECT
  Genre,
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Genre IS NOT NULL
GROUP BY Genre
ORDER BY ventes_mondiales_millions DESC;


-- Ventes mondiales de jeux par plateforme
SELECT
  vs.Platform,
  p.Nom_Complet,
  ROUND(SUM(vs.Global_Sales), 2) AS ventes_mondiales_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean` AS vs
LEFT JOIN `BDD_Call_Of_Data.plateformes` AS p
  ON vs.Platform = p.Platform
GROUP BY
  vs.Platform,
  p.Nom_Complet
ORDER BY ventes_mondiales_millions DESC;


-- Ventes de jeux par région
SELECT
  ROUND(SUM(NA_Sales), 2) AS ventes_Amerique_du_Nord_millions,
  ROUND(SUM(EU_Sales), 2) AS ventes_Europe_millions,
  ROUND(SUM(JP_Sales), 2) AS ventes_Japon_millions,
  ROUND(SUM(Other_Sales), 2) AS ventes_Autres_millions
FROM `BDD_Call_Of_Data.ventes_scores_clean`;


-- Répartition géographique des ventes pour le Top 10 éditeurs
SELECT
  Publisher,
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions,
  ROUND(SUM(NA_Sales), 2) AS ventes_Amerique_du_Nord_millions,
  ROUND(SUM(NA_Sales) / SUM(Global_Sales) * 100, 2) AS part_Amerique_du_Nord_pourcent,
  ROUND(SUM(EU_Sales), 2) AS ventes_Europe_millions,
  ROUND(SUM(EU_Sales) / SUM(Global_Sales) * 100, 2) AS part_Europe_pourcent,
  ROUND(SUM(JP_Sales), 2) AS ventes_Japon_millions,
  ROUND(SUM(JP_Sales) / SUM(Global_Sales) * 100, 2) AS part_Japon_pourcent,
  ROUND(SUM(Other_Sales), 2) AS ventes_Autres_millions,
  ROUND(SUM(Other_Sales) / SUM(Global_Sales) * 100, 2) AS part_Autres_pourcent
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY ventes_mondiales_millions DESC
LIMIT 10;


-- =============================================================
-- 3.2 ANALYSES PAR CRITIC SCORE (NOTES DES CRITIQUES)
-- =============================================================

-- Critic score moyen global
SELECT
  ROUND(AVG(Critic_Score), 2) AS critic_score_moyen
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Critic_Score IS NOT NULL;


-- Top 10 éditeurs par critic score
SELECT
  Publisher,
  ROUND(AVG(Critic_Score), 2) AS critic_score_moyen,
  COUNT(*) AS nb_jeux_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
  AND Critic_Score IS NOT NULL
GROUP BY Publisher
ORDER BY critic_score_moyen DESC
LIMIT 10;


-- Critic score moyen par genre
SELECT
  Genre,
  ROUND(AVG(Critic_Score), 2) AS critic_score_moyen,
  COUNT(*) AS nb_jeux_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Genre IS NOT NULL
  AND Critic_Score IS NOT NULL
GROUP BY Genre
ORDER BY critic_score_moyen DESC;


-- Critic score moyen par plateforme
SELECT
  vs.Platform,
  p.Nom_Complet,
  ROUND(AVG(vs.Critic_Score), 2) AS critic_score_moyen,
  COUNT(*) AS nb_jeux_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean` AS vs
LEFT JOIN `BDD_Call_Of_Data.plateformes` AS p
  ON vs.Platform = p.Platform
WHERE vs.Critic_Score IS NOT NULL
GROUP BY
  vs.Platform,
  p.Nom_Complet
ORDER BY critic_score_moyen DESC;


-- Comparaison performances ventes vs performances critic score
SELECT
  Publisher,
  ROUND(SUM(Global_Sales), 2) AS ventes_mondiales_millions,
  ROUND(AVG(Critic_Score), 2) AS critic_score_moyen,
  COUNT(DISTINCT Name) AS nb_jeux,
  COUNT(Critic_Score) AS nb_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
GROUP BY Publisher
ORDER BY ventes_mondiales_millions DESC;


-- =============================================================
-- 3.3 ANALYSES PAR USER SCORE (NOTES DES UTILISATEURS)
-- =============================================================

-- User score moyen global
SELECT
  ROUND(AVG(User_Score), 2) AS score_utilisateur_moyen
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE User_Score IS NOT NULL;


-- Top 10 éditeurs par user score moyen
SELECT
  Publisher,
  ROUND(AVG(User_Score), 2) AS score_utilisateur_moyen,
  COUNT(*) AS nb_jeux_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
  AND User_Score IS NOT NULL
GROUP BY Publisher
ORDER BY score_utilisateur_moyen DESC
LIMIT 10;


-- User score moyen par genre
SELECT
  Genre,
  ROUND(AVG(User_Score), 2) AS score_utilisateur_moyen,
  COUNT(*) AS nb_jeux_notes
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Genre IS NOT NULL
  AND User_Score IS NOT NULL
GROUP BY Genre
ORDER BY score_utilisateur_moyen DESC;


-- Comparaison critic score & user score par éditeur
SELECT
  Publisher,
  ROUND(AVG(Critic_Score), 2) AS critic_score_moyen,
  ROUND(AVG(User_Score), 2) AS user_score_moyen,
  COUNT(*) AS nb_jeux_avec_les_deux_scores
FROM `BDD_Call_Of_Data.ventes_scores_clean`
WHERE Publisher IS NOT NULL
  AND Critic_Score IS NOT NULL
  AND User_Score IS NOT NULL
GROUP BY Publisher
ORDER BY critic_score_moyen DESC;


-- Vérification du taux de complétude des notes (pertinence de la comparaison)
SELECT
  COUNT(*) AS nb_lignes,
  COUNT(User_Score) AS nb_user_score,
  ROUND(COUNT(User_Score) / COUNT(*) * 100, 2) AS user_score_pourcent,
  COUNT(Critic_Score) AS nb_critic_score,
  ROUND(COUNT(Critic_Score) / COUNT(*) * 100, 2) AS critic_score_pourcent
FROM `BDD_Call_Of_Data.ventes_scores_clean`;
