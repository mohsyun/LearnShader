using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CreaterWindow : EditorWindow
{

    public List<GameObject> objList = new List<GameObject>();

    private string materialName;
    private Shader shader ;

    private SerializedObject serializedObject;
    private SerializedProperty serializedProperty;

    private SerializedObject serializedObjectTwo;
    private SerializedProperty serializedPropertyTwo;

    private bool isAdd;
    private object m;

    [MenuItem("Tools/ChangeShader")]
    private static void Window()
    {
        CreaterWindow _editorTest = (CreaterWindow)EditorWindow.GetWindow(typeof(CreaterWindow), false, "ChangeShader", true);
        _editorTest.Show();
    }

    private void OnEnable()
    {

        serializedObject = new SerializedObject(this);
        serializedProperty = serializedObject.FindProperty("objList");
        serializedPropertyTwo = serializedObject.FindProperty("shader");

        shader = default;

    }
    private void OnGUI()
    {
        serializedObject.Update();
        EditorGUI.BeginChangeCheck();
     
        EditorGUILayout.PropertyField(serializedProperty, true);
        if (EditorGUI.EndChangeCheck())
        {
            serializedObject.ApplyModifiedProperties();
        }

        GUILayout.BeginHorizontal();
        GUILayout.FlexibleSpace();//插入一个弹性空白
        if (GUILayout.Button("Add"))
        {
            if (!isAdd)
            {
                objList.Add(default);
            }
        }
        GUILayout.EndHorizontal();

        //GUILayout.FlexibleSpace();//插入一个弹性空白
        //EditorGUILayout.PropertyField(serializedObject.FindProperty("shader"));

        if (objList == null || objList.Count <= 0)
        {
            EditorGUILayout.HelpBox("objList == null || objList.Count <= 0 ", MessageType.Warning);
        }

        shader = EditorGUILayout.ObjectField("shader",shader,typeof(Shader),true) as Shader;

        materialName = EditorGUILayout.TextField("材质保存路径", materialName);

        GUILayout.FlexibleSpace();//插入一个弹性空白


     


        if (shader == null)
        {
            EditorGUILayout.HelpBox("shader == null ", MessageType.Error);
        }
        else if (GUILayout.Button("Go"))
        {
            if (objList == null || objList.Count <= 0) return;

            ChangeObjShader();
        }



    }



    private void ChangeObjShader()
    {
        if (objList.Count <= 0) return;

        isAdd = true;
        string mn;
        if (materialName != "")
        {
            mn =  materialName + "/";
        }
        else
        {
            mn = "";
        }

        for (int i = 0; i < objList.Count; i++)
        {
            Material parentMatrial = null;

            if (objList[i].GetComponent<MeshRenderer>())
            {
                MeshRenderer m = objList[i].GetComponent<MeshRenderer>();
              
                Material mat = new Material(shader);

                mat.mainTexture = m.sharedMaterial.mainTexture;
                AssetDatabase.CreateAsset(mat, "Assets/" + mn + objList[i].name + "mat.mat");
                m.sharedMaterial = mat;
                parentMatrial = mat;
                
                //if (m != default && m != null)
                //{
                //    m.shader = shader;
                //}
                //else if (m == default || m == null)
                //{
                //}

            }

            MeshRenderer[] mr = objList[i].GetComponentsInChildren<MeshRenderer>();

            if (mr.Length > 0)
            {
                for (int m = 0; m < mr.Length; m++)
                {
                    Material mat = new Material(shader);
                    mat.mainTexture = mr[m].sharedMaterial.mainTexture;
                    AssetDatabase.CreateAsset(mat, "Assets/" + mn + mr[m].gameObject.name + "mat.mat");
                    mr[m].sharedMaterial = mat;                 
                }
            }
            
        }

        isAdd = false;
        //mono.StartCoroutine(Change());
    }


}

