class Frame
    def initialize
        @score = 0
        @shot_count = 0
        @bonus = 0
        @bonus_count = 0
    end

    def record_shot(pins)
        @score += pins
        @shot_count += 1
    end

    def score
        @score += @bonus
    end

    def finished?
        @score >= 10 || @shot_count > 1
    end

    def spare?
        @score == 10 && @shot_count > 1
    end

    def strike?
        @score >= 10 && @shot_count == 1
    end

    def add_bonus(bonus)
        @bonus += bonus
        @bonus_count += 1
    end

    def need_bonus?
        if spare?
            @bonus_count < 1
        elsif strike?
            @bonus_count < 2
        else
            false
        end
    end
end