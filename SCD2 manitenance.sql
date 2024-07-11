
---------------------------------- SCD2 Maintenance for ProductDIm --------------------------------------------------
INSERT INTO ProductDim (ProdDim_Id, Product_id, Product_name, Product_category, Product_subcategory, Effective_From, Effective_To, CurrentFlag)
VALUES (51199, 'TEC-AC-100018301', 'Router33', 'Technology', 'Accessories', '12/09/2023', '12/31/9999', TRUE);

UPDATE ProductDim
SET Effective_To = '12/11/2023'::date - 1,
CurrentFlag = FALSE
WHERE ProdDim_Id = 10;

SELECT *
FROM ProductDim
WHERE ProdDim_Id IN (10, 51199);


--------------------------- SCD2 Maintenance for ProductDIm - using function ----------------------------------------
DROP FUNCTION IF EXISTS ManageProduct(integer, character varying, character varying, character varying, character varying, date, date, boolean);

CREATE OR REPLACE FUNCTION ManageProduct(
    p_ProdDim_Id INTEGER,
    p_Product_id VARCHAR(255),
    p_Product_name VARCHAR(255),
    p_Product_category VARCHAR(255),
    p_Product_subcategory VARCHAR(255),
    p_Effective_From DATE,
    p_Effective_To DATE,
    p_CurrentFlag BOOLEAN,
    OUT result_ProdDim_Id INTEGER,
    OUT result_Product_id VARCHAR(255),
    OUT result_Product_name VARCHAR(255),
    OUT result_Product_category VARCHAR(255),
    OUT result_Product_subcategory VARCHAR(255),
    OUT result_Effective_From DATE,
    OUT result_Effective_To DATE,
    OUT result_CurrentFlag BOOLEAN
)
AS
$$
BEGIN
    -- Insert record
    INSERT INTO ProductDim (ProdDim_Id, Product_id, Product_name, Product_category, Product_subcategory, Effective_From, Effective_To, CurrentFlag)
    VALUES (p_ProdDim_Id, p_Product_id, p_Product_name, p_Product_category, p_Product_subcategory, p_Effective_From, p_Effective_To, p_CurrentFlag)
    RETURNING * INTO
        result_ProdDim_Id,
        result_Product_id,
        result_Product_name,
        result_Product_category,
        result_Product_subcategory,
        result_Effective_From,
        result_Effective_To,
        result_CurrentFlag;

    -- Update record
    UPDATE ProductDim
    SET Effective_To = p_Effective_From - INTERVAL '1 day',
        CurrentFlag = FALSE
    WHERE ProdDim_Id = p_ProdDim_Id;
END;
$$ LANGUAGE plpgsql;


SELECT ManageProduct(51194, 'TEC-AC-100018301', 'Router25', 'Technology', 'Accessories', '2023-09-12'::DATE, '9999-12-31'::DATE, TRUE);

-- Drop the function if it exists
DROP FUNCTION IF EXISTS ManageProduct(integer, character varying, character varying, character varying, character varying, date, date, boolean);

DROP TABLE StagingProductDim;
CREATE TABLE StagingProductDim (
    ProdDim_Id SERIAL PRIMARY KEY,
    Product_id VARCHAR(255),
    Product_name VARCHAR(255),
    Product_category VARCHAR(255),
    Product_subcategory VARCHAR(255),
    Effective_From DATE,
    Effective_To DATE,
    CurrentFlag BOOLEAN
);

-- Create or replace the function
CREATE OR REPLACE FUNCTION ManageProduct(
    p_ProdDim_Id INTEGER,
    p_Product_id VARCHAR(255),
    p_Product_name VARCHAR(255),
    p_Product_category VARCHAR(255),
    p_Product_subcategory VARCHAR(255),
    p_Effective_From DATE,
    p_Effective_To DATE,
    p_CurrentFlag BOOLEAN,
    OUT result_ProdDim_Id INTEGER,
    OUT result_Product_id VARCHAR(255),
    OUT result_Product_name VARCHAR(255),
    OUT result_Product_category VARCHAR(255),
    OUT result_Product_subcategory VARCHAR(255),
    OUT result_Effective_From DATE,
    OUT result_Effective_To DATE,
    OUT result_CurrentFlag BOOLEAN
)
AS
$$
DECLARE
    v_StagingId INTEGER;
BEGIN
    -- Insert record into staging area
    INSERT INTO StagingProductDim (Product_id, Product_name, Product_category, Product_subcategory, Effective_From, Effective_To, CurrentFlag)
    VALUES (p_Product_id, p_Product_name, p_Product_category, p_Product_subcategory, p_Effective_From, p_Effective_To, p_CurrentFlag)
    RETURNING ProdDim_Id INTO v_StagingId;

    -- Move records from staging to actual table in a transaction
    BEGIN
        -- Insert new record
        INSERT INTO ProductDim (Product_id, Product_name, Product_category, Product_subcategory, Effective_From, Effective_To, CurrentFlag)
        SELECT
            p_Product_id,
            p_Product_name,
            p_Product_category,
            p_Product_subcategory,
            p_Effective_From,
            p_Effective_To,
            p_CurrentFlag
        FROM StagingProductDim
        WHERE ProdDim_Id = v_StagingId
        RETURNING
            ProdDim_Id,
            Product_id,
            Product_name,
            Product_category,
            Product_subcategory,
            Effective_From,
            Effective_To,
            CurrentFlag
        INTO
            result_ProdDim_Id,
            result_Product_id,
            result_Product_name,
            result_Product_category,
            result_Product_subcategory,
            result_Effective_From,
            result_Effective_To,
            result_CurrentFlag;

        -- Update old record
        UPDATE ProductDim
        SET Effective_To = p_Effective_From - INTERVAL '1 day',
            CurrentFlag = FALSE
        WHERE ProdDim_Id = p_ProdDim_Id;
    END;

    -- Retrieve the result from the actual table
    SELECT
        result_ProdDim_Id,
        result_Product_id,
        result_Product_name,
        result_Product_category,
        result_Product_subcategory,
        result_Effective_From,
        result_Effective_To,
        result_CurrentFlag;
END;
$$ LANGUAGE plpgsql;



SELECT ManageProduct(51199, 'TEC-AC-100018301', 'Router55', 'Technology', 'Accessories', '2023-09-12'::DATE, '9999-12-31'::DATE, TRUE);





------------SCD2 Maintenance for CustomerDim---------

INSERT INTO CustomerDim (customerId, customer_id, customer_name, customer_city, customer_state, customer_country, Effective_From, Effective_To, CurrentFlag)
VALUES (9999, 'NEW-CUSTOMER-ID', 'New Customer', 'New City', 'New State', 'New Country', '12/09/2023', '12/31/9999', TRUE);


UPDATE CustomerDim
SET Effective_To = '12/08/2023'::date - 1,
    CurrentFlag = FALSE
WHERE customerId = 1; -- Replace with the actual customerId you want to update

-- Retrieve both versions for inspection
SELECT *
FROM CustomerDim
WHERE customerId IN (1, 9999);



