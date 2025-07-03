--Painting Types
INSERT INTO painting_type VALUES (1, 'Landscape');
INSERT INTO painting_type VALUES (2, 'Abstract');
INSERT INTO painting_type VALUES (3, 'Portrait');

--Exhibition Types
INSERT INTO exhibition_type VALUES (1, 'Solo');
INSERT INTO exhibition_type VALUES (2, 'Group');
INSERT INTO exhibition_type VALUES (3, 'Virtual');

--Artists
INSERT INTO artist VALUES (101, 'Ravi Varma', 'Kerala, India', '9876543210', SYSDATE, NULL, 'N');
INSERT INTO artist VALUES (102, 'Amrita Sher-Gil', 'Delhi, India', '9988776655', SYSDATE, NULL, 'N');

--Galleries
INSERT INTO gallery VALUES (201, 'Kala Sangrah', 'Mumbai', SYSDATE, NULL);
INSERT INTO gallery VALUES (202, 'ArtSphere', 'Bangalore', SYSDATE, NULL);

--ExhibitionsINSERT INTO exhibition VALUES (
  301, 'Brushstroke Bliss', 'Mumbai', DATE '2024-09-01', DATE '2024-09-10', 201, 2, SYSDATE, NULL
);

INSERT INTO exhibition VALUES (
  302, 'Color Symphony', 'Bangalore', DATE '2024-10-01', DATE '2024-10-15', 202, 1, SYSDATE, NULL
);

--Paintings
INSERT INTO painting VALUES (
  401, 'Rainfall Melody', 2024, 1, 101, 250000, 95, 301, 'N', 'N', SYSDATE, NULL
);

INSERT INTO painting VALUES (
  402, 'Abstract Horizon', 2023, 2, 102, 550000, 97, 302, 'N', 'N', SYSDATE, NULL
);

INSERT INTO painting VALUES (
  403, 'Mountain Whisper', 2022, 1, 101, 300000, 89, 301, 'N', 'N', SYSDATE, NULL
);

INSERT INTO painting VALUES (
  404, 'City Pulse', 2021, 2, 102, 700000, 93, 302, 'N', 'N', SYSDATE, NULL
);

--Customers
INSERT INTO customer VALUES (
  501, 'Asmita Waghmare', '9123456789', 'Sangli, Maharashtra', 'N', SYSDATE, NULL
);

INSERT INTO customer VALUES (
  502, 'Rehan Kapoor', '9000099999', 'Pune, Maharashtra', 'N', SYSDATE, NULL
);

--Purchases
INSERT INTO purchase VALUES (
  601, 501, 401, SYSDATE - 30, 250000
);

INSERT INTO purchase VALUES (
  602, 501, 403, SYSDATE - 20, 290000
);

INSERT INTO purchase VALUES (
  603, 502, 402, SYSDATE - 10, 550000
);

