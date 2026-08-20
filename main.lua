function Weapon()
    local weapon = {}
    --

    weapon.type = "sword"
    weapon.length = 100
    weapon.damage = 10
    weapon.isactive = false

    function weapon:attack()
        print("Attacking with " .. weapon.type .. " for " .. weapon.damage .. " damage!")
    end

    function weapon:update(dt, px, py)
        -- moving sword with player
        weapon.x = px + 50
        weapon.y = py - 10

        -- moving sword while active
        if weapon.isactive then
            local sin = love.mouse.getX() - px 
            local cos = love.mouse.getY() - py 
            local angle = math.atan2(cos, sin)
            weapon.x = math.cos(angle) * weapon.length + px
            weapon.y = math.sin(angle) * weapon.length + py
        end
    end

    function weapon:draw()
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.x, self.y, self.length, 20)
        love.graphics.line('fill', self.x)
        love.graphics.setColor(1, 1, 1)
    end
    return weapon
end

function love.load()
    local wpn = Weapon()
    player = {
        x = 400,
        y = 300,
        speed = 200,
        weapon = {
            wpn = wpn,
            dmg = wpn.damage
        }
    }

end

function love.update(dt)
    love.mouse.setVisible(false)

    -- movement
    if love.keyboard.isDown("up", "w") then
        player.y = player.y - player.speed * dt
    elseif love.keyboard.isDown("down", "s") then
        player.y = player.y + player.speed * dt
    end

    if love.keyboard.isDown("left", "a") then
        player.x = player.x - player.speed * dt

    elseif love.keyboard.isDown("right", "d") then
        player.x = player.x + player.speed * dt
    end

    if love.mouse.isDown(1) then
        player.weapon.wpn.isactive = true
        player.weapon.wpn:attack()
    else
        player.weapon.wpn.isactive = false
    end

    player.weapon.wpn:update(dt, player.x, player.y) 



    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
end

function love.draw()
    --draw mouse
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 2)
    love.graphics.setColor(1, 1, 1)

    love.graphics.circle("fill", player.x, player.y, 50)

    player.weapon.wpn:draw()
end
