/* QUERY CON SELECT */

/* 1. Selezionare tutti gli studenti nati nel 1990 (160) */
SELECT *
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990


/* 2. Selezionare tutti i corsi che valgono più di 10 crediti (479) */
SELECT *
FROM `courses`
WHERE `cfu`> 10 

/* 3. Selezionare tutti gli studenti che hanno più di 30 anni */
SELECT *
FROM `students`
WHERE TIMESTAMPDIFF(YEAR,`date_of_birth`, CURDATE()) > 30;

/* 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea(286) */
SELECT *
FROM `courses`
WHERE `period` = "I semestre" 
AND `year` = 1

/* 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21) */
SELECT *
FROM `exams`
WHERE `date` = "2020/06/20"
AND `hour` >= "14:00:00"

/* 6. Selezionare tutti i corsi di laurea magistrale (38) */
SELECT *
FROM `degrees`
WHERE `level` = "magistrale"

/* 7. Da quanti dipartimenti è composta l'università? (12) */
SELECT COUNT(`id`) AS `num_departments`
FROM `departments`


/* 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50) */
SELECT COUNT(`id`) AS `teachers_with_no_phone`
FROM `teachers`
WHERE `phone` IS NULL

/* QUERY CON GROUP BY */

/* 1. Contare quanti iscritti ci sono stati ogni anno */
SELECT YEAR(`enrolment_date`) AS `year`, COUNT(`id`) AS `num_enrolments`
FROM `students`
GROUP BY `year`
ORDER BY `year` DESC

/* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio */
SELECT `office_address`, COUNT(`id`) AS `num_teachers`
FROM `teachers`
GROUP BY `office_address`
HAVING `num_teachers` > 1

/* 3. Calcolare la media dei voti di ogni appello d'esame */
SELECT `exam_id`,FLOOR(AVG(`vote`)) AS `media_votes`
FROM `exam_student`
GROUP BY `exam_id`


/* 4. Contare quanti corsi di laurea ci sono per ogni dipartimento */
SELECT `department_id`, COUNT(`id`) AS `num_courses`
FROM `degrees`
GROUP BY `department_id`

