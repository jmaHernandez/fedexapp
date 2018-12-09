module Utils
    def hello
        "hello"
    end

    def CalcularPesoKilogramos(weight, units)
        if units == "LB" 
            weight = weight / 2.2046
        end

        return weight.ceil
    end

    def CalcularPesoVolumetrico(width, height, length, units)
        if units == "IN"
            width = width * 2.54
            height = height * 2.54
            length = length * 2.54
        end

        return ((width * height * length) / 5000).ceil
    end

    def CalcularSobrepeso(peso_total, peso_fedex_total)
        return peso_fedex_total - peso_total
    end
end