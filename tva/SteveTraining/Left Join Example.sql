SELECT Professor.Id AS [Professor.Id], Professor.ProfessorName,
      CASE Professor.HasTenure WHEN 1 THEN 'True' WHEN 0 THEN 'False' ELSE NULL END AS [Has Tenure],
      Class.ProfessorId AS [Class.ProfessorId], Class.ClassName,
      Class.ClassYear, Class.ClassSemester
 FROM Professor
   LEFT OUTER JOIN Class
      ON Professor.Id = Class.ProfessorId
      AND Class.ClassYear >= 2011
 WHERE Professor.HasTenure = 1