-- 8. afficher prix total 
SELECT recette.nom_recette, ROUND(SUM(prix*qtt), 2) 
FROM ingredient
INNER JOIN recette_ingredient ON recette_ingredient.id_ingredient = ingredient.id_ingredient
INNER JOIN recette ON recette.id_recette = recette_ingredient.id_recette
GROUP BY nom_recette;

-- 9. afficher detail d'une recette 
SELECT recette.id_recette, recette.nom_recette, nom_ingredient, recette_ingredient.qtt, unite, prix
FROM ingredient
INNER JOIN recette_ingredient ON recette_ingredient.id_ingredient = ingredient.id_ingredient
INNER JOIN recette ON recette.id_recette = recette_ingredient.id_recette
WHERE recette.id_recette = 5;

-- 10. ajouter un ingredient dans la bdd 
INSERT INTO ingredient (nom_ingredient, unite, prix)
 VALUES ('Poivre', 'càs', 1.2);

--  11. modifier un prix 
UPDATE ingredient 
SET prix = '2.58'
WHERE id_ingredient = 10;

-- 12. afficher le nombre de recette par catégorie 
SELECT COUNT(recette.nom_recette), nom_categorie
FROM categorie
INNER JOIN recette ON recette.id_categorie = categorie.id_categorie
GROUP BY nom_categorie;

-- 13. afficher les noms contenant le mot 'poulet'
SELECT recette.nom_recette, nom_ingredient 
FROM ingredient
INNER JOIN recette_ingredient ON recette_ingredient.id_ingredient= ingredient.id_ingredient
INNER JOIN recette ON recette.id_recette = recette_ingredient.id_recette
WHERE nom_ingredient LIKE '%poulet%';

-- 14. diminuer temps de prep à 5mn
UPDATE recette 
SET temps_prep = 5;

-- 15. afficher les recettes coûtant -2e
SELECT nom_recette
FROM recette
WHERE id_recette NOT IN (
	SELECT recette_ingredient.id_recette
	FROM recette_ingredient
	INNER JOIN ingredient ON recette_ingredient.id_ingredient = ingredient.id_ingredient
	WHERE prix > 2
);

-- 16. afficher la recette la plus rapide à préparer
SELECT nom_recette, temps_prep
FROM recette
WHERE temps_prep = (
	SELECT MIN(temps_prep) 
	FROM recette
	);

-- 17. recette sans ingredient 
SELECT nom_recette
FROM recette
WHERE id_recette NOT IN (
   SELECT id_recette
   FROM recette_ingredient
   INNER JOIN ingredient ON recette_ingredient.id_ingredient = ingredient.id_ingredient
);

-- 18. trouver les ingrédients utilisés dans au moins 3 recettes
SELECT nom_ingredient
FROM ingredient
WHERE id_ingredient IN (
   	SELECT id_ingredient 
   	FROM recette_ingredient
	GROUP BY id_ingredient
	HAVING COUNT(id_ingredient) >= 3
);

-- 19. ajouter un nouvel ingredient à une recette spécifique 
INSERT INTO ingredient (nom_ingredient, unite, prix)
VALUES ('Banane', 'p', 2.5);
INSERT INTO recette_ingredient (id_recette, id_ingredient, qtt)
VALUES (9, LAST_INSERT_ID(), 1);
