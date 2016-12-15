local lush = {}
-- arbitrary arguments operators
function lush.add(...)
	local res = 0;
	for i,v in ipairs({...}) do res = res + v	end
	return res
end
function lush.sub(res, ...)
	for i,v in ipairs({...}) do res = res - v	end
	return res
end
function lush.mul(...)
	local res = 1;
	for i,v in ipairs({...}) do res = res * v	end
	return res
end
function lush.div(res, ...)
	for i,v in ipairs({...}) do res = res / v	end
	return res
end
function lush.cat(...)
	local res = "";
	for i,v in ipairs({...}) do res = res .. v	end
	return res
end
function lush.conjuction(...)
	local res = true;
	for i,v in ipairs({...}) do res = res and v	end
	return res
end
function lush.disjunction(...)
	local res = true;
	for i,v in ipairs({...}) do res = res or v	end
	return res
end
function lush.equ(...)
	local arg = {...}
	if #arg<1 then return true end
	tmp = arg[1];
	for i=2, #arg do
		if tmp~=arg[i] then return false end
	end
	return true
end
function lush.noteq(...)
	local arg = {...}
	if #arg==1 then return true end
	if #arg==2 then return arg[1]==arg[2] end
	for i,v in ipairs({...}) do
		for j,w in ipairs({...}) do
			if v==w then return false end
		end
	end
	return res
end
-- binary operators
function lush.mod(a,b)
	return a%b
end
function lush.pow(a,b)
	return a^b
end
function lush.less(a,b)
	return a<b
end
function lush.greater(a,b)
	return a>b
end
function lush.lesseq(a,b)
	return a<=b
end
function lush.greatereq(a,b)
	return a>=b
end
return lush
