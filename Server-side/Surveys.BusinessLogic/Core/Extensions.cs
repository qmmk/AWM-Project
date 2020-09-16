using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data;
using System.Linq;
using System.Reflection;

namespace Surveys.BusinessLogic.Core
{
    public static class DataTableExtensions
    {
        public static T Bind<T>(this SqlDataReader dr) where T : new()
        {
            T retval = new T();
            if (dr.Read())
            {
                for (int i = 0; i < dr.FieldCount; i++)
                {
                    var prop = typeof(T).GetProperties().Where(x => x.Name == dr.GetName(i)).SingleOrDefault();
                    if (prop != null)
                    {
                        bool notMapped = false;
                        object[] attrs = prop.GetCustomAttributes(true);
                        foreach (object attr in attrs)
                        {
                            NotMappedAttribute notMappedAttr = attr as NotMappedAttribute;
                            notMapped = notMappedAttr != null;
                            if (notMapped)
                                break;
                        }
                        if (!notMapped)
                        {
                            object objvalue = null;
                            try
                            {
                                objvalue = dr.GetFieldValue<object>(dr.GetOrdinal(prop.Name));
                            }
                            catch (Exception se)
                            {

                            }
                            if (objvalue == System.DBNull.Value)
                                objvalue = null;

                            prop.SetValue(retval, objvalue);
                        }
                    }
                }
            }

            return retval;
        }

        public static T RealBind<T>(this SqlDataReader dr) where T : new()
        {
            T retval = new T();

            for (int i = 0; i < dr.FieldCount; i++)
            {
                var prop = typeof(T).GetProperties().Where(x => x.Name == dr.GetName(i)).SingleOrDefault();
                if (prop != null)
                {
                    bool notMapped = false;
                    object[] attrs = prop.GetCustomAttributes(true);
                    foreach (object attr in attrs)
                    {
                        NotMappedAttribute notMappedAttr = attr as NotMappedAttribute;
                        notMapped = notMappedAttr != null;
                        if (notMapped)
                            break;
                    }
                    if (!notMapped)
                    {
                        object objvalue = null;
                        try
                        {
                            objvalue = dr.GetFieldValue<object>(dr.GetOrdinal(prop.Name));
                        }
                        catch (Exception se)
                        {

                        }
                        if (objvalue == System.DBNull.Value)
                            objvalue = null;

                        prop.SetValue(retval, objvalue);
                    }
                }
            }

            return retval;
        }

        public static List<T> BindToList<T>(this SqlDataReader dr) where T : new()
        {
            List<T> retval = new List<T>();
            while (dr.Read())
            {
                retval.Add(RealBind<T>(dr));
            }
            return retval;
        }

        public static T First<T>(this DataTable dt)
        {
            const BindingFlags flags = BindingFlags.Public | BindingFlags.Instance;
            var columnNames = dt.Columns.Cast<DataColumn>()
                .Select(c => c.ColumnName)
                .ToList();
            var objectProperties = typeof(T).GetProperties(flags);
            var targetList = dt.AsEnumerable().Select(dataRow =>
            {
                var instanceOfT = Activator.CreateInstance<T>();

                foreach (var properties in objectProperties.Where(properties => columnNames.Contains(properties.Name) && dataRow[properties.Name] != DBNull.Value))
                {
                    properties.SetValue(instanceOfT, dataRow[properties.Name], null);
                }
                return instanceOfT;
            }).ToList().FirstOrDefault();

            return targetList;
        }


    }
}
