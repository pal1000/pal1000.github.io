@FOR /F delims^=^ eol^= %%a IN (";e 3") DO @echo %%a // Both EOL and delims disabled
@FOR /F eol^= %%a IN (" e 3") DO @echo %%a // EOL disabled with space delims
@FOR /F delims^=-^ eol^= %%a IN (" e - 3") DO @echo %%a // EOL disabled with custom delims
@FOR /F delims^=^=^ eol^= %%a IN (" e = 3") DO @echo %%a // EOL disabled with escaped custom delims
@pause