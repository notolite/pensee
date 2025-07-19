set ext=%~x1
magick %1 %2 -fx "u==v ? u : ( (u.r + u.g + u.b) < (v.r + v.g + v.b) ? u : v )"  output%ext%