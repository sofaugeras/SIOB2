# TP GSB 🏥

!!! success "🎯 Objectifs pédagogiques"
    Révision de toutes les notions SQL vues depuis le début de l'année

    |Partie|Thème|Questions|
    |:--|:--|:-|
    |1|SELECT / WHERE / ORDER BY / LIKE / IS NULL|Q1–Q6|
    |2|INNER JOIN|Q7–Q11|
    |3|Agrégats + GROUP BY|Q12–Q16|
    |4|HAVING|Q17–Q19|
    |5|Vues |Q20–Q22|
    |6|Sous-requêtes (IN, NOT IN, corrélée)|Q23–Q26|
    |7|UNION / intersection / différence|Q27–Q29|
    |8|LEFT JOIN / RIGHT JOIN |Q30–Q33|

## Méthode — Comment construire une requête SQL ?

!!! info "À retenir : ordre des clauses"
    `SELECT` → `FROM` → `JOIN` → `WHERE` → `GROUP BY` → `HAVING` → `ORDER BY` → `LIMIT`

### Étape 1 — SELECT : que veut-on afficher ?

**Mots-clés :** `*` `colonne` `AS` `DISTINCT` `COUNT()` `SUM()` `AVG()` `MAX()` `MIN()`
```sql
SELECT VIS_NOM, Vis_PRENOM, VIS_VILLE
FROM visiteur;
```

!!! success "Conseil"
    Utilise des alias (`AS`) pour rendre les colonnes calculées lisibles.
    Ex : `COUNT(*) AS nb_visites`

!!! warning "Piège"
    Ne jamais mettre une colonne dans `SELECT` si elle n'est pas dans `GROUP BY`
    (sauf si elle est agrégée).

### Étape 2 — FROM / JOIN : quelles tables ?

**Mots-clés :** `FROM` `INNER JOIN` `LEFT JOIN` `RIGHT JOIN` `ON`
```sql
SELECT v.VIS_NOM, s.SEC_LIBELLE
FROM visiteur v
JOIN secteur s ON v.SEC_CODE = s.SEC_CODE;
```

!!! success "Conseil"
    Préfixe toujours les colonnes avec le nom (ou alias) de la table dès qu'il y a
    plusieurs tables. Ex : `v.VIS_NOM`

!!! warning "Piège"
    `JOIN` (= `INNER JOIN`) ne retourne que les lignes qui ont une correspondance dans
    les deux tables. <br />
    Utilise `LEFT JOIN` pour garder toutes les lignes de la table de gauche.

### Étape 3 — WHERE : filtrer les lignes

**Mots-clés :** `=` `<>` `<` `>` `BETWEEN` `IN` `NOT IN` `LIKE` `IS NULL` `IS NOT NULL` `AND` `OR` `NOT`
```sql
SELECT MED_NOMCOMMERCIAL
FROM medicament
WHERE FAM_CODE = 'ABP'
  AND MED_PRIXECHANTILLON IS NOT NULL;
```

!!! success "Conseil"
    `WHERE` s'applique **avant** tout regroupement. Il agit sur les lignes brutes,
    pas sur les agrégats.

!!! warning "Piège"
    On ne peut **pas** écrire `WHERE COUNT(*) > 3` → il faut `HAVING` pour filtrer
    sur un agrégat.

### Étape 4 — GROUP BY : regrouper pour calculer

**Mots-clés :** `GROUP BY` `COUNT()` `SUM()` `AVG()` `MAX()` `MIN()`
```sql
SELECT FAM_CODE, COUNT(*) AS nb_med
FROM medicament
GROUP BY FAM_CODE;
```

!!! success "Conseil"
    Toute colonne non agrégée dans le `SELECT` doit apparaître dans le `GROUP BY`.

!!! warning "Piège"
    Si tu n'utilises pas de fonction d'agrégat, tu n'as pas besoin de `GROUP BY`.

### Étape 5 — HAVING : filtrer sur les groupes

**Mots-clés :** `HAVING` `COUNT()` `SUM()` `AVG()` `MAX()` `MIN()`
```sql
SELECT VIS_MATRICULE, SUM(OFF_QTE) AS total
FROM offrir
GROUP BY VIS_MATRICULE
HAVING SUM(OFF_QTE) > 10;
```

!!! success "Conseil"
    `HAVING` vient toujours **après** `GROUP BY`. C'est le seul endroit où on peut
    filtrer sur `COUNT()`, `SUM()`…

!!! warning "Piège"
    `WHERE` filtre les lignes **avant** le regroupement. `HAVING` filtre les groupes
    **après**.

### Étape 6 — ORDER BY / LIMIT : trier et limiter

**Mots-clés :** `ORDER BY` `ASC` `DESC` `LIMIT` `OFFSET`
```sql
SELECT VIS_NOM, COUNT(*) AS nb_visites
FROM rapport_visite r
JOIN visiteur v ON r.VIS_MATRICULE = v.VIS_MATRICULE
GROUP BY v.VIS_MATRICULE
ORDER BY nb_visites DESC
LIMIT 5;
```

!!! success "Conseil"
    On peut trier sur un alias défini dans le `SELECT`. Ex : `ORDER BY nb_visites DESC`

!!! warning "Piège"
    Sans `ORDER BY`, l'ordre des résultats n'est **pas garanti**. Ne jamais supposer
    un ordre par défaut.

## Présentation de la base de données

La base `gsb` modélise le système d'information d'un laboratoire pharmaceutique. Des **visiteurs médicaux** effectuent des visites chez des **praticiens** (médecins, etc.) pour leur présenter des **médicaments**. Chaque visite donne lieu à un **rapport de visite**, et des **échantillons** peuvent être offerts lors de ces visites.

### Schéma simplifié des tables principales

```sql
LABO (LAB_CODE, LAB_NOM, LAB_CHEFVENTE)
SECTEUR (SEC_CODE, SEC_LIBELLE)
REGION (REG_CODE, SEC_CODE, REG_NOM)
VISITEUR (VIS_MATRICULE, VIS_NOM, Vis_PRENOM, VIS_ADRESSE, VIS_CP, VIS_VILLE,
          VIS_DATEEMBAUCHE, SEC_CODE, LAB_CODE)
FAMILLE (FAM_CODE, FAM_LIBELLE)
MEDICAMENT (MED_DEPOTLEGAL, MED_NOMCOMMERCIAL, FAM_CODE, MED_COMPOSITION,
            MED_EFFETS, MED_CONTREINDIC, MED_PRIXECHANTILLON)
PRATICIEN (PRA_NUM, PRA_NOM, PRA_PRENOM, PRA_ADRESSE, PRA_CP, PRA_VILLE,
           PRA_COEFNOTORIETE, TYP_CODE)
TYPE_PRATICIEN (TYP_CODE, TYP_LIBELLE, TYP_LIEU)
RAPPORT_VISITE (VIS_MATRICULE, RAP_NUM, PRA_NUM, RAP_DATE, RAP_BILAN, RAP_MOTIF)
OFFRIR (VIS_MATRICULE, RAP_NUM, MED_DEPOTLEGAL, OFF_QTE)
SPECIALITE (SPE_CODE, SPE_LIBELLE)
```

## Partie 1 — Manipulation de données sans jointure 🔍

!!! info "Objectif"
    Maîtriser les clauses `SELECT`, `WHERE`, `ORDER BY`, `LIKE`, `BETWEEN`, `IN`, `IS NULL`.

**Q1.** Affichez le nom commercial et le code famille de tous les médicaments, triés par nom commercial dans l'ordre alphabétique.

??? question "Correction"
    ```sql
    SELECT MED_NOMCOMMERCIAL, FAM_CODE
    FROM medicament
    ORDER BY MED_NOMCOMMERCIAL ASC;
    ```

**Q2.** Affichez le matricule, le nom et la ville de tous les visiteurs habitant à **Paris** (CP commençant par `75`).

??? question "Correction"
    ```sql
    SELECT VIS_MATRICULE, VIS_NOM, VIS_VILLE
    FROM visiteur
    WHERE VIS_CP LIKE '75%';
    ```

**Q3.** Listez les médicaments dont le prix échantillon est compris entre **5 et 15 euros** (inclus). Affichez le nom commercial et le prix.

??? question "Correction"
    ```sql
    SELECT MED_NOMCOMMERCIAL, MED_PRIXECHANTILLON
    FROM medicament
    WHERE MED_PRIXECHANTILLON BETWEEN 5 AND 15;
    ```

**Q4.** Affichez les médicaments dont le prix échantillon est **non renseigné** (`NULL`).

??? question "Correction"
    ```sql
    SELECT MED_NOMCOMMERCIAL
    FROM medicament
    WHERE MED_PRIXECHANTILLON IS NULL;
    ```

**Q5.** Listez les visiteurs appartenant aux secteurs `'E'`, `'O'` ou `'N'`. Affichez leur nom, prénom et code secteur.

??? question "Correction"
    ```sql
    SELECT VIS_NOM, Vis_PRENOM, SEC_CODE
    FROM visiteur
    WHERE SEC_CODE IN ('E', 'O', 'N');
    ```

**Q6.** Affichez les rapports de visite rédigés **après le 1er janvier 2015**, triés par date décroissante.

??? question "Correction"
    ```sql
    SELECT VIS_MATRICULE, RAP_NUM, RAP_DATE
    FROM rapport_visite
    WHERE RAP_DATE > '2015-01-01'
    ORDER BY RAP_DATE DESC;
    ```

## Partie 2 — Jointures classiques (INNER JOIN) 🔗

!!! info "Objectif"
    Combiner plusieurs tables avec des jointures internes.

**Q7.** Affichez le nom des visiteurs avec le libellé de leur secteur.

??? question "Correction"
    ```sql
    SELECT v.VIS_NOM, v.Vis_PRENOM, s.SEC_LIBELLE
    FROM visiteur v
    JOIN secteur s ON v.SEC_CODE = s.SEC_CODE;
    ```

**Q8.** Listez les médicaments avec le libellé de leur famille pharmaceutique.

??? question "Correction"
    ```sql
    SELECT m.MED_NOMCOMMERCIAL, f.FAM_LIBELLE
    FROM medicament m
    JOIN famille f ON m.FAM_CODE = f.FAM_CODE;
    ```

**Q9.** Affichez, pour chaque rapport de visite, le nom du visiteur, le nom du praticien visité et la date de la visite.

??? question "Correction"
    ```sql
    SELECT v.VIS_NOM, p.PRA_NOM, r.RAP_DATE
    FROM rapport_visite r
    JOIN visiteur v ON r.VIS_MATRICULE = v.VIS_MATRICULE
    JOIN praticien p ON r.PRA_NUM = p.PRA_NUM;
    ```

**Q10.** Pour chaque échantillon offert, affichez le nom du visiteur, le nom commercial du médicament offert et la quantité.

??? question "Correction"
    ```sql
    SELECT v.VIS_NOM, m.MED_NOMCOMMERCIAL, o.OFF_QTE
    FROM offrir o
    JOIN visiteur v ON o.VIS_MATRICULE = v.VIS_MATRICULE
    JOIN medicament m ON o.MED_DEPOTLEGAL = m.MED_DEPOTLEGAL;
    ```

**Q11.** Affichez les praticiens avec le libellé de leur type (généraliste, spécialiste…) et leur lieu d'exercice.

??? question "Correction"
    ```sql
    SELECT p.PRA_NOM, p.PRA_PRENOM, tp.TYP_LIBELLE, tp.TYP_LIEU
    FROM praticien p
    JOIN type_praticien tp ON p.TYP_CODE = tp.TYP_CODE;
    ```

## Partie 3 — Calculs et agrégats 🔢

!!! info "Objectif"
    Utiliser `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` et `GROUP BY`.

**Q12.** Combien y a-t-il de visiteurs au total dans la base ?

??? question "Correction"
    ```sql
    SELECT COUNT(*) AS nb_visiteurs
    FROM visiteur;
    ```

**Q13.** Pour chaque laboratoire, affichez son nom et le nombre de visiteurs qui y travaillent.

??? question "Correction"
    ```sql
    SELECT l.LAB_NOM, COUNT(v.VIS_MATRICULE) AS nb_visiteurs
    FROM labo l
    JOIN visiteur v ON l.LAB_CODE = v.LAB_CODE
    GROUP BY l.LAB_CODE, l.LAB_NOM;
    ```

**Q14.** Affichez, par famille de médicament, le nombre de médicaments, le prix moyen et le prix maximum de l'échantillon.

??? question "Correction"
    ```sql
    SELECT FAM_CODE,
           COUNT(*) AS nb_medicaments,
           ROUND(AVG(MED_PRIXECHANTILLON), 2) AS prix_moyen,
           MAX(MED_PRIXECHANTILLON) AS prix_max
    FROM medicament
    GROUP BY FAM_CODE;
    ```

**Q15.** Pour chaque visiteur, calculez le nombre total d'échantillons offerts au cours de toutes ses visites.

??? question "Correction"
    ```sql
    SELECT VIS_MATRICULE, SUM(OFF_QTE) AS total_echantillons
    FROM offrir
    GROUP BY VIS_MATRICULE
    ORDER BY total_echantillons DESC;
    ```

**Q16.** Pour chaque praticien, comptez le nombre de visites reçues.

??? question "Correction"
    ```sql
    SELECT PRA_NUM, COUNT(*) AS nb_visites
    FROM rapport_visite
    GROUP BY PRA_NUM
    ORDER BY nb_visites DESC;
    ```

## Partie 4 — Filtrage sur les agrégats avec HAVING 🎯

!!! info "Objectif"
    Distinguer `WHERE` (filtre sur les lignes) et `HAVING` (filtre sur les groupes).

**Q17.** Listez les familles de médicaments qui comptent **plus de 3 médicaments**.

??? question "Correction"
    ```sql
    SELECT FAM_CODE, COUNT(*) AS nb_medicaments
    FROM medicament
    GROUP BY FAM_CODE
    HAVING COUNT(*) > 3;
    ```

**Q18.** Affichez les visiteurs ayant offert **plus de 10 échantillons** au total.

??? question "Correction"
    ```sql
    SELECT VIS_MATRICULE, SUM(OFF_QTE) AS total_echantillons
    FROM offrir
    GROUP BY VIS_MATRICULE
    HAVING SUM(OFF_QTE) > 10;
    ```

**Q19.** Listez les praticiens qui ont reçu **au moins 3 visites**, en affichant leur numéro et le nombre de visites.

??? question "Correction"
    ```sql
    SELECT PRA_NUM, COUNT(*) AS nb_visites
    FROM rapport_visite
    GROUP BY PRA_NUM
    HAVING COUNT(*) >= 3;
    ```

## Partie 5 — Vues 👁️

!!! info "Objectif"
    Créer et exploiter des vues pour simplifier des requêtes complexes.

**Q20.** Créez une vue `vue_visiteurs_secteur` qui affiche pour chaque visiteur : son matricule, son nom, son prénom et le libellé de son secteur.

??? question "Correction"
    ```sql
    CREATE VIEW vue_visiteurs_secteur AS
    SELECT v.VIS_MATRICULE, v.VIS_NOM, v.Vis_PRENOM, s.SEC_LIBELLE
    FROM visiteur v
    JOIN secteur s ON v.SEC_CODE = s.SEC_CODE;
    ```

**Q21.** En utilisant la vue créée à la question précédente, listez tous les visiteurs du secteur **Est**.

??? question "Correction"
    ```sql
    SELECT *
    FROM vue_visiteurs_secteur
    WHERE SEC_LIBELLE = 'Est';
    ```

**Q22.** Créez une vue `vue_bilan_offres` qui affiche, pour chaque médicament, son nom commercial et le total d'échantillons offerts (toutes visites confondues).

??? question "Correction"
    ```sql
    CREATE VIEW vue_bilan_offres AS
    SELECT m.MED_NOMCOMMERCIAL, SUM(o.OFF_QTE) AS total_offerts
    FROM medicament m
    JOIN offrir o ON m.MED_DEPOTLEGAL = o.MED_DEPOTLEGAL
    GROUP BY m.MED_DEPOTLEGAL, m.MED_NOMCOMMERCIAL;
    ```

## Partie 6 — Requêtes imbriquées (sous-requêtes) 🪆

!!! info "Objectif"
    Utiliser des sous-requêtes dans `WHERE`, `FROM` ou `SELECT`.

**Q23.** Affichez les médicaments dont le prix échantillon est **supérieur au prix moyen** de tous les médicaments.

??? question "Correction"
    ```sql
    SELECT MED_NOMCOMMERCIAL, MED_PRIXECHANTILLON
    FROM medicament
    WHERE MED_PRIXECHANTILLON > (
        SELECT AVG(MED_PRIXECHANTILLON)
        FROM medicament
    );
    ```

**Q24.** Listez les visiteurs qui ont **rédigé au moins un rapport de visite** (sans utiliser de jointure).

??? question "Correction"
    ```sql
    SELECT VIS_NOM, Vis_PRENOM
    FROM visiteur
    WHERE VIS_MATRICULE IN (
        SELECT DISTINCT VIS_MATRICULE
        FROM rapport_visite
    );
    ```

**Q25.** Affichez les praticiens qui **n'ont jamais été visités**.

??? question "Correction"
    ```sql
    SELECT PRA_NOM, PRA_PRENOM
    FROM praticien
    WHERE PRA_NUM NOT IN (
        SELECT DISTINCT PRA_NUM
        FROM rapport_visite
    );
    ```

**Q26.** Pour chaque visiteur, affichez son nom et le nombre de rapports rédigés (via une sous-requête corrélée dans le `SELECT`).

??? question "Correction"
    ```sql
    SELECT v.VIS_NOM, v.Vis_PRENOM,
           (SELECT COUNT(*)
            FROM rapport_visite r
            WHERE r.VIS_MATRICULE = v.VIS_MATRICULE) AS nb_rapports
    FROM visiteur v;
    ```

## Partie 7 — Opérateurs ensemblistes ∪ ∩ ∖

!!! info "Objectif"
    Utiliser `UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT` (ou `MINUS`).

> **Note MySQL :** MySQL ne supporte pas `INTERSECT` ni `EXCEPT` nativement (avant MySQL 8.0.31). On les émule avec des jointures ou des sous-requêtes.

**Q27.** Construisez la liste unifiée des villes où résident des **visiteurs** et des villes où exercent des **praticiens** (sans doublons).

??? question "Correction"
    ```sql
    SELECT VIS_VILLE AS ville FROM visiteur
    UNION
    SELECT PRA_VILLE FROM praticien;
    ```

**Q28.** Affichez les villes présentes **à la fois** parmi les visiteurs et parmi les praticiens (intersection).

??? question "Correction"
    ```sql
    -- Émulation de l'intersection avec IN
    SELECT DISTINCT VIS_VILLE AS ville
    FROM visiteur
    WHERE VIS_VILLE IN (
        SELECT PRA_VILLE FROM praticien
    );
    ```

**Q29.** Affichez les villes de visiteurs **qui ne sont pas** des villes de praticiens (différence ensembliste).

??? question "Correction"
    ```sql
    -- Émulation de EXCEPT avec NOT IN
    SELECT DISTINCT VIS_VILLE AS ville
    FROM visiteur
    WHERE VIS_VILLE NOT IN (
        SELECT PRA_VILLE FROM praticien WHERE PRA_VILLE IS NOT NULL
    );
    ```

## Partie 8 — LEFT JOIN et RIGHT JOIN 🔄

!!! info "Objectif"
    Comprendre et utiliser les jointures externes pour conserver les lignes sans correspondance.

**Q30.** Listez **tous les visiteurs**, y compris ceux n'ayant rédigé aucun rapport, en affichant leur nom et le nombre de rapports rédigés.

??? question "Correction"
    ```sql
    SELECT v.VIS_NOM, v.Vis_PRENOM, COUNT(r.RAP_NUM) AS nb_rapports
    FROM visiteur v
    LEFT JOIN rapport_visite r ON v.VIS_MATRICULE = r.VIS_MATRICULE
    GROUP BY v.VIS_MATRICULE, v.VIS_NOM, v.Vis_PRENOM;
    ```

**Q31.** Affichez **tous les médicaments**, même ceux qui n'ont jamais été offerts en échantillon. Pour ceux offerts, indiquer la quantité totale, sinon `0`.

??? question "Correction"
    ```sql
    SELECT m.MED_NOMCOMMERCIAL,
           COALESCE(SUM(o.OFF_QTE), 0) AS total_offerts
    FROM medicament m
    LEFT JOIN offrir o ON m.MED_DEPOTLEGAL = o.MED_DEPOTLEGAL
    GROUP BY m.MED_DEPOTLEGAL, m.MED_NOMCOMMERCIAL;
    ```

**Q32.** En utilisant un `RIGHT JOIN`, listez **tous les praticiens** (même non visités) avec le nom du visiteur qui les a visités en dernier. Affichez `NULL` si aucune visite.

??? question "Correction"
    ```sql
    SELECT p.PRA_NOM, p.PRA_PRENOM, v.VIS_NOM AS dernier_visiteur, MAX(r.RAP_DATE) AS derniere_visite
    FROM rapport_visite r
    JOIN visiteur v ON r.VIS_MATRICULE = v.VIS_MATRICULE
    RIGHT JOIN praticien p ON r.PRA_NUM = p.PRA_NUM
    GROUP BY p.PRA_NUM, p.PRA_NOM, p.PRA_PRENOM, v.VIS_NOM;
    ```

**Q33.** *(Question de synthèse)* Affichez, pour chaque laboratoire, le nombre de visiteurs et le montant total des échantillons offerts par ces visiteurs. Incluez les laboratoires même s'ils n'ont aucune offre enregistrée.

??? question "Correction"
    ```sql
    SELECT l.LAB_NOM,
           COUNT(DISTINCT v.VIS_MATRICULE) AS nb_visiteurs,
           COALESCE(SUM(o.OFF_QTE), 0) AS total_echantillons
    FROM labo l
    LEFT JOIN visiteur v ON l.LAB_CODE = v.LAB_CODE
    LEFT JOIN offrir o ON v.VIS_MATRICULE = o.VIS_MATRICULE
    GROUP BY l.LAB_CODE, l.LAB_NOM;
    ```
