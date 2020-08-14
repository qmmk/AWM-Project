﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using Microsoft.IdentityModel.Tokens;
using Surveys.BusinessLogic.DataAccess;
using Surveys.BusinessLogic.Interfaces;
using Surveys.WebAPIService.Models;


namespace Surveys.WebAPIService.Services
{
    public class UserService
    {
        #region Properties
        private static MapperConfiguration _mapperConfig;
        private static IMapper _mapper;
        private static readonly Lazy<UserService> _instance = new Lazy<UserService>(() => new UserService());
        public static UserService Instance { get { return _instance.Value; } }
        #endregion

        private UserService() 
        {
            _mapperConfig = new MapperConfiguration(
                cfg => cfg.CreateMap<Principal, UserDTO>());
            _mapper = _mapperConfig.CreateMapper();
        }

        public UserDTO Authenticate(Principal principal, byte[] key)
        {
            UserDTO user = _mapper.Map<UserDTO>(principal);

            //authentication successful so generate jwt token
            // ACCESS
            var tokenHandler = new JwtSecurityTokenHandler();
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Issuer = "Surveys",
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.PID.ToString()),
                    new Claim("HWID", Guid.NewGuid().ToString())
                }),
                Expires = DateTime.UtcNow.AddDays(1),
                SigningCredentials = new SigningCredentials(
                    new SymmetricSecurityKey(key),
                    SecurityAlgorithms.HmacSha256Signature
                )
            };

            var accessToken = tokenHandler.CreateToken(tokenDescriptor);
            user.AccessToken = tokenHandler.WriteToken(accessToken);

            
            if (user.RefreshToken == null || !user.RefreshToken.IsActive) 
            {
                //REFRESH
                var randomBytes = new byte[64];
                using (var rngCryptoServiceProvider = new RNGCryptoServiceProvider())
                {
                    rngCryptoServiceProvider.GetBytes(randomBytes);
                }

                user.RefreshToken = new RefreshToken
                {
                    rToken = Convert.ToBase64String(randomBytes),
                    Expires = DateTime.UtcNow.AddDays(7),
                    CreatedBy = user.PID
                };
            }

            return user;
        }

    }
}