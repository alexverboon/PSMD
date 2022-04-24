# Microsoft 365 Defender PowerShell Module

[![Minimum Supported PowerShell Version](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://github.com/PowerShell/PowerShell) ![Cross Platform](https://img.shields.io/badge/platform-windows-lightgrey)


<p align="center">
    <img src="./media/small_psmd.png" alt="PSMDATP Logo" >
</p>

Welcome to the Microsoft 365 Defender PowerShell Module!

This module is a collection of easy-to-use cmdlets and functions designed to make it easy to interface with the Microsoft Defender 365 solutions API.

---

## PowerShell Module in Development

This PowerShell module is **stil in development**, as soon as we have a reasonable amount of cmdlets, the module will be published to the PowerShell Gallery.

Here's the [to do list](./to_do.md)

---

## API Permissions

To use this PowerShell Module, you will need to register an app in Azure Active Directory, create a client secret and grant API permissions to the app.
For a complete list of API permissions see [API Permissions](./API_Permissions.md)

## Credentials

By default the cmdlets in the PSMD Module tries to retrieve the credentials to access the API from the psmdconfig.json file.

```json
{
    "API_PSMD":  {
        "AppName":  "PSMD",
        "TenantId": "<TENANT ID>",
        "ClientId":  "<APP REGISTRATION APP ID>",
        "ClientSecret":  "<APP REGISTRATION Client Securet>"
    }
}
```

---

## Contributing

If you have an idea or want to contribute to this project please submit a suggestion

## Authors

**Alex Verboon** [Twitter](https://twitter.com/alexverboon)

## Contributors

**Dan Lacher** [Twitter](https://twitter.com/DanLacher)

---

## Release Notes

| Version |    Date    |                           Notes                                |
| ------- | ---------- | -------------------------------------------------------------- |
| 0.0.1   | 23.04.2022 | Initial Release                                                |

---

## Important

I am going to assume that you are familiar with Microsoft 365 Defender as such and understand the consequences of triggering actions on devices or other entities within Microsoft 365 Defender, Azure or AzureAD. Where applicable the cmdlets support the use the ***-whatif*** parameter. Think before pressing the key!

The maintainers for ths PowerShell Module are not responsible for any damage caused by using this module.

