--[[
    GTC 1v1 Draft - Precomputed Solver Module
    Generated automatically by gtc_solver (Rust Engine)
    Zero-overhead, pure lookup & deterministic evaluation
--]]

local RustSolver = {}
RustSolver.VERSION = "1.0.0"

-- Config parameters determined by Rust Solver
RustSolver.CONFIG = {
    ANTI_FREE_THRESHOLD = 1.84,
    MONSTER_THRESHOLD = 71.12,
    EARLY_TRASH_CAP = 3,
    EARLY_MID_CAP = 7,
    EARLY_HIGH_CAP = 12,
    LATE_TRASH_CAP = 4,
    LATE_MID_CAP = 10,
    DIV_35 = 3.25,
    DIV_16 = 3.24,
    DIV_10 = 3.46,
    DIV_6_5 = 4.00,
    BURN_LOTS = 3,
}

-- Evaluates max bid instantly with 0ms lag
function RustSolver.evaluate(lotIdx, totalLots, v, cash, rivalCash, myScore, rivalScore)
    if cash <= 0 then return 0 end
    local lotsLeft = math.max(totalLots - 1 - lotIdx, 0)
    local diff = myScore - rivalScore

    -- 1. Final Lot All-In
    if lotsLeft == 0 then
        if diff == v and cash > rivalCash then return 0 end
        return cash
    end

    -- 2. Clinch Lock
    if diff > (lotsLeft * 35.0) and lotsLeft >= 1 then
        return (v >= 10.0) and math.min(1, cash) or 0
    end

    -- 3. Rival is broke
    if rivalCash == 0 then
        return (v >= 3.0) and math.min(1, cash) or 0
    end

    local strictSurplus = math.max(0, cash - (rivalCash + 1))

    -- 4. Monster Carry Lock
    local isMonster = (v >= RustSolver.CONFIG.MONSTER_THRESHOLD) or (lotsLeft <= 2 and v >= 35.0)
    if isMonster then
        return (cash > rivalCash) and math.min(cash, rivalCash + 1) or cash
    end

    -- 5. Anti-Snowball Deficit Cap
    local maxTolerable = (lotsLeft >= 5 and -16.0) or (lotsLeft >= 3 and -12.0) or (lotsLeft == 2 and -7.5) or -3.5
    if diff < maxTolerable and v >= 7.5 then
        if cash > rivalCash then
            return math.min(5, math.max(1, strictSurplus))
        else
            return math.min(cash, math.max(2, math.floor(cash / 2)))
        end
    end

    -- 6. Dynamic Value Drain
    local baseCap = 0
    if v >= 35.0 then baseCap = math.floor(v / RustSolver.CONFIG.DIV_35)
    elseif v >= 16.0 then baseCap = math.floor(v / RustSolver.CONFIG.DIV_16)
    elseif v >= 10.0 then baseCap = math.floor(v / RustSolver.CONFIG.DIV_10)
    elseif v >= 6.5 then baseCap = math.floor(v / RustSolver.CONFIG.DIV_6_5)
    elseif v >= RustSolver.CONFIG.ANTI_FREE_THRESHOLD then baseCap = 1 end

    -- 7. Phase Budget Pacing
    if lotsLeft >= 4 then
        if v < 20.0 then baseCap = math.min(baseCap, RustSolver.CONFIG.EARLY_TRASH_CAP)
        elseif v < 40.0 then baseCap = math.min(baseCap, RustSolver.CONFIG.EARLY_MID_CAP)
        else baseCap = math.min(baseCap, RustSolver.CONFIG.EARLY_HIGH_CAP) end
    elseif lotsLeft >= 2 then
        if v < 20.0 then baseCap = math.min(baseCap, RustSolver.CONFIG.LATE_TRASH_CAP)
        elseif v < 40.0 then baseCap = math.min(baseCap, RustSolver.CONFIG.LATE_MID_CAP) end
    end

    -- 8. Late Game Cash Burn
    if lotsLeft <= RustSolver.CONFIG.BURN_LOTS and cash >= (lotsLeft * 3) and v >= 6.5 then
        baseCap = math.max(baseCap, math.floor(cash / (lotsLeft + 1)))
    end

    if strictSurplus > 0 and v >= 6.5 then
        baseCap = math.max(baseCap, strictSurplus)
    end

    return math.min(cash, baseCap)
end

return RustSolver
