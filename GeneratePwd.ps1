param(
	[int]$Length = 16,
	[switch]$IncludeSymbols,
	[switch]$IncludeNumbers,
	[switch]$IncludeUppercase,
	[switch]$Strong
)

function New-Password {
    param(
        [int]$Length = 16,
        [switch]$IncludeSymbols,
        [switch]$IncludeNumbers,
        [switch]$IncludeUppercase,
        [switch]$Strong
    )

    $lower   = 'abcdefghijklmnopqrstuvwxyz'
    $upper   = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $numbers = '0123456789'
    $symbols = '!@#$%^&*()-_=+[]{}|;:,.<>?'

    $charPool = $lower
    if ($IncludeUppercase -or $Strong) { $charPool += $upper }
    if ($IncludeNumbers -or $Strong)   { $charPool += $numbers }
    if ($IncludeSymbols -or $Strong)   { $charPool += $symbols }

    # fallback: if no extras selected, include numbers & uppercase
    if ($charPool -eq $lower) { $charPool += $numbers + $upper }

	$password = ""

	if ($Strong) {
		# Ensure at least one of each category
		$password += $lower[(Get-Random -Max $lower.Length)]
		$password += $upper[(Get-Random -Max $upper.Length)]
		$password += $numbers[(Get-Random -Max $numbers.Length)]
		$password += $symbols[(Get-Random -Max $symbols.Length)]

		# Fill the rest randomly
		$remaining = $Length - $password.Length
		if ($remaining -gt 0) {
			for ($i = 0; $i -lt $remaining; $i++) {
				$password += $charPool[(Get-Random -Max $charPool.Length)]
			}
		}

		# Shuffle so guaranteed chars aren’t always at the start
		$password = -join ($password.ToCharArray() | Sort-Object {Get-Random})
	}
	else {
		for ($i = 0; $i -lt $Length; $i++) {
			$password += $charPool[(Get-Random -Max $charPool.Length)]
		}
	}

	return $password
}

# Example usage:
# Normal random (with options)
#New-Password -Length 20 -IncludeSymbols -IncludeNumbers -IncludeUppercase

# Strong (guarantees at least one lowercase, uppercase, number, and symbol)
#New-Password -Length 20 -Strong

New-Password @PSBoundParameters