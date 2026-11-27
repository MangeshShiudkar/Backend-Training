# MongoDB Advanced Assignment Answers

## Task 5.2: explain("executionStats") Results

Actual values recorded from the local MongoDB instance:

- **Winning plan stage:** `IXSCAN`
- **nReturned:** `2`
- **totalDocsExamined:** `2`
- **totalKeysExamined:** `2`

The top-level explain plan showed a `FETCH` stage, with `IXSCAN` used to locate the matching documents through the `departmentId_1_name_1` compound index.

## MCQ Answers

Q1: B

Q2: B

Q3: C

Q4: A

Q5: C

Q6: B

Q7: C

Q8: B

Q9: C

Q10: B

Q11: A

Q12: C
