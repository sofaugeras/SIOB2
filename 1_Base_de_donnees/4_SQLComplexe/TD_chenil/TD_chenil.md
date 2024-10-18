# TD Chenil

![chenil](./data/chenil_illustration.png){: width=30% .center}

!!! note "Objectif du TP"

	- Mettre en oeuvre les jointures internes et externes

![chenil](./data/chenil.png){: width=50% .center}

^^schéma relationnel :^^

**CHIEN** (^^num_ch^^, nom_ch, race, sexe, #num_cage, #code_pro)<br />
**PROPRIETAIRE**(^^code_pro^^, nom_pro, tel_pro, ville_pro, rue_pro, cp_pro) <br />
**MANGER**(^^#num_ch, #code_al^^, quantite, date_repas)<br />
**ALIMENT**(^^code_al^^, nom_al)<br />
**CAGE**(^^num_cage^^, nbmax, surface)<br />

:question: 1. **Décompter le nombre de chien par cage. Affichez aussi les numéros de cage vide.**
??? question "correction"
    ```SQL
    SELECT cage.NumCage, COUNT(Num_Ch)
    FROM Cage
    LEFT OUTER JOIN Chien
    ON Cage.NumCage = Chien.NumCage
    GROUP BY Cage.NumCage
    ```

    Attention: ``COUNT(*)`` donnerai 1, même pour une cage vide, car il y a une ligne qui lui correspond.


:question: 2. **Lister les chiens avec les détails de leurs propriétaires**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race, ch.sexe, p.nom_pro, p.tel_pro
    FROM CHIEN ch
    INNER JOIN PROPRIETAIRE p ON ch.code_pro = p.code_pro;
    ```

:question: 3. **Lister tous les chiens et leurs repas, même ceux qui n'ont pas encore mangé**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race, m.quantite, m.date_repas
    FROM CHIEN ch
    LEFT JOIN MANGER m ON ch.num_ch = m.num_ch;
    ```

:question: 4. **Lister tous les aliments et les chiens qui les ont mangés, même si certains aliments n'ont pas été consommés**
??? question "correction"
    ```sql
    SELECT a.nom_al, m.num_ch, m.quantite, m.date_repas
    FROM ALIMENT a
    RIGHT JOIN MANGER m ON a.code_al = m.code_al;
    ```

:question: 5. **Lister tous les chiens et les cages où ils sont logés, même si certaines cages sont vides**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race, c.num_cage, c.nbmax, c.surface
    FROM CHIEN ch
    LEFT JOIN CAGE c ON ch.num_cage = c.num_cage;
    ```

:question: 6. **Lister toutes les cages et les chiens qui y sont logés, même si certaines cages sont vides (RIGHT JOIN) :**
??? question "correction"
    ```sql
    SELECT c.num_cage, c.nbmax, c.surface, ch.nom_ch, ch.race
    FROM CAGE c
    RIGHT JOIN CHIEN ch ON c.num_cage = ch.num_cage;
    ```

:question: 7. **Quels chiens n'ont pas encore mangé ?**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race
    FROM CHIEN ch
    LEFT JOIN MANGER m ON ch.num_ch = m.num_ch
    WHERE m.num_ch IS NULL;
    ```

:question: 8. **Quels aliments n'ont jamais été consommés ?**
??? question "correction"
    ```sql
    SELECT a.nom_al
    FROM ALIMENT a
    LEFT JOIN MANGER m ON a.code_al = m.code_al
    WHERE m.code_al IS NULL;
    ```

:question: 9. **Combien de repas chaque chien a-t-il pris ?**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race, COUNT(m.num_ch) AS nombre_repas
    FROM CHIEN ch
    LEFT JOIN MANGER m ON ch.num_ch = m.num_ch
    GROUP BY ch.nom_ch, ch.race;
    ```

:question: 10. **Quels propriétaires ont le plus de chiens ?**
??? question "correction"
    ```sql
    SELECT p.nom_pro, p.tel_pro, COUNT(ch.num_ch) AS nombre_chiens
    FROM PROPRIETAIRE p
    LEFT JOIN CHIEN ch ON p.code_pro = ch.code_pro
    GROUP BY p.nom_pro, p.tel_pro
    ORDER BY nombre_chiens DESC;
    ```

:question: 11. **Quels chiens ont consommé plus de 5 kg de nourriture en une journée ?**
??? question "correction"
    ```sql
    SELECT ch.nom_ch, ch.race, SUM(m.quantite) AS total_quantite
    FROM CHIEN ch
    JOIN MANGER m ON ch.num_ch = m.num_ch
    GROUP BY ch.nom_ch, ch.race, m.date_repas
    HAVING SUM(m.quantite) > 5;
    ```