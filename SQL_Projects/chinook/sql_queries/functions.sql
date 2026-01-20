/* =========================================================
   SECTION 1: Discounted Price Calculation
   Business Problem:
   How can we consistently calculate discounted prices
   across multiple queries without repeating logic?
   ========================================================= */

-- Create a user-defined function to calculate discounted price
-- Inputs:
--   @OriginalPrice  : Original item price
--   @DiscountRate  : Discount percentage
-- Output:
--   Discounted price after applying the discount

CREATE FUNCTION CalculateDiscountedPrice
(
    @OriginalPrice DECIMAL(10,2),
    @DiscountRate DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @OriginalPrice - (@OriginalPrice * @DiscountRate / 100);
END;



/* =========================================================
   SECTION 2: Function Validation
   Business Question:
   Does the discount calculation work correctly
   for a sample value?
   ========================================================= */

-- Test the function using a sample input
SELECT dbo.CalculateDiscountedPrice(100, 10) AS DiscountedPrice;



/* =========================================================
   SECTION 3: Applying Function to Business Data
   Business Question:
   How can we apply the discount logic to real product data?
   ========================================================= */

-- Apply the discount function to track prices
-- Demonstrates reuse of business logic across rows

SELECT TrackID,
       Name,
       UnitPrice,
       dbo.CalculateDiscountedPrice(UnitPrice, 10) AS FinalAmount
FROM Track;
