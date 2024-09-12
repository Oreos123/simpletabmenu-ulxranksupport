local frame

hook.Add("ScoreboardShow", "CustomScoreboard", function()
    if not IsValid(frame) then
        frame = vgui.Create("DFrame")
        frame:SetSize(ScrW(), ScrH())
        frame:Center()
        frame:SetTitle("")
        frame:ShowCloseButton(false)
        frame:MakePopup()
        frame.Paint = function(self, w, h)
            Derma_DrawBackgroundBlur(self, self.startTime)
            draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 240))
        end
        frame.startTime = SysTime()

        local serverName = vgui.Create("DLabel", frame)
        serverName:SetText(GetHostName())
        serverName:SetFont("Trebuchet24")
        serverName:SetTextColor(Color(255, 255, 255))
        serverName:Dock(TOP)
        serverName:DockMargin(10, 10, 10, 10)
        serverName:SetContentAlignment(5)
        
        serverName:SetSize(200, 50)

        local header = vgui.Create("DPanel", frame)
        header:SetSize(0, 32)
        header:Dock(TOP)
        header.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50))
        end
		
		local avatarHeader = vgui.Create("DLabel", header)
		avatarHeader:SetText("Аватар")
		avatarHeader:SetFont("Trebuchet18")
		avatarHeader:SetTextColor(Color(255, 255, 255))
		avatarHeader:Dock(LEFT)

		local nameHeader = vgui.Create("DLabel", header)
		nameHeader:SetText("Имя")
		nameHeader:SetFont("Trebuchet18")
		nameHeader:SetTextColor(Color(255, 255, 255))
		nameHeader:Dock(LEFT)
		nameHeader:DockMargin(10, 0, 0, 0)

        local pingHeader = vgui.Create("DLabel", header)
        pingHeader:SetText("Пинг")
        pingHeader:SetFont("Trebuchet18")
        pingHeader:SetTextColor(Color(255, 255, 255))
        pingHeader:Dock(RIGHT)

        local rankHeader = vgui.Create("DLabel", header)
		rankHeader:SetText("Ранг")
		rankHeader:SetFont("Trebuchet18")
		rankHeader:SetTextColor(Color(255, 255, 255))
		rankHeader:Dock(FILL)
		rankHeader:SetContentAlignment(5)
        rankHeader:MoveLeftOf(pingHeader)

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)
		
		local bar = vgui.Create("DPanel", scroll)
		bar:SetSize(0, 2)
		bar:Dock(TOP)
		bar:DockMargin(0, 10, 0, 0)
		bar.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255))
		
		end



        for i, ply in pairs(player.GetAll()) do
            local pnl = vgui.Create("DPanel", scroll)
            pnl:SetSize(0, 64)
            pnl:Dock(TOP)
            if i == 1 then
                pnl:DockMargin(0, 10, 0, 5)
            else
                pnl:DockMargin(0, 0, 0, 5)
            end
            pnl.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(50, 50, 50))
            end

			local avatar = vgui.Create("DPanel", pnl)
			avatar:SetSize(66, 66)
			avatar:Dock(LEFT)
			avatar.Paint = function(self, w, h)
			surface.SetDrawColor(255, 255, 255)
			surface.DrawOutlinedRect(0, 0, w, h)

			local x, y = self:LocalToScreen(0, 0)
			local scrW, scrH = ScrW(), ScrH()
			render.SetScissorRect(x, y, x + w, y + h, true)

			avatarImage = vgui.Create("AvatarImage", avatar)
			avatarImage:SetSize(64, 64)
			avatarImage:SetPlayer(ply, 64)

			render.SetScissorRect(0, 0, scrW, scrH, false)
			end

            local name = vgui.Create("DLabel", pnl)
            name:SetText(ply:Nick())
            name:SetFont("Trebuchet24")
            name:SetTextColor(Color(255, 255, 255))
            name:Dock(LEFT)
			
			local admin = vgui.Create("DLabel", pnl)
			admin:SetText(ply:GetUserGroup())
			admin:SetFont("Trebuchet24")
			admin:Dock(FILL)
			admin:SetContentAlignment(5)

			if ply:GetUserGroup() == "user" then
				admin:SetTextColor(Color(0, 0, 255))
			elseif ply:GetUserGroup() == "admin" then
				admin:SetTextColor(Color(255, 255, 0))
			elseif ply:GetUserGroup() == "superadmin" then
				admin:SetTextColor(Color(255, 0, 0))
			else
				admin:SetTextColor(Color(255, 255, 255))
			end	

			local ping = vgui.Create("DLabel", pnl)
			ping:SetFont("Trebuchet24")
			ping:SetTextColor(Color(255, 255, 255))
			ping:Dock(RIGHT)

			timer.Create("UpdatePing" .. ply:UserID(), 0, 0, function()
				if not IsValid(ping) then
					timer.Remove("UpdatePing" .. ply:UserID())
				return
    end

    ping:SetText(ply:Ping())
end)


            admin:MoveLeftOf(ping) 
        end
    end

    return true
end)

hook.Add("ScoreboardHide", "CustomScoreboard", function()
    if IsValid(frame) and not input.IsKeyDown(KEY_TAB) then
            frame:Remove()
    end
end)

hook.Add("Think", "CustomScoreboard", function()
    if IsValid(frame) and not input.IsKeyDown(KEY_TAB) then
        frame:Remove()
    end
end)
