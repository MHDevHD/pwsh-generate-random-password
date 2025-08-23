# Normal random (with options)
.\GenerateRandomPwd.ps1 -Length 32 -IncludeSymbols -IncludeNumbers -IncludeUppercase

# Strong (guarantees at least one lowercase, uppercase, number, and symbol)
.\GenerateRandomPwd.ps1 -Length 32 -Strong
